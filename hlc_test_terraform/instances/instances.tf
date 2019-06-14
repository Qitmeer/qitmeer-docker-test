provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "network_configuration" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket}"
    key    = "${var.remote_state_key}"
    region = "${var.region}"
  }
}

resource "aws_security_group" "ec2_private_security_group" {
  name        = "EC2-Test-SG"
  description = "Internet reaching access for EC2 Instances"
  vpc_id      = "${data.terraform_remote_state.network_configuration.vpc_id}"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ec2_iam_role" {
  name               = "EC2-IAM-Role"
  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" :
  [
    {
      "Effect" : "Allow",
      "Principal" : {
        "Service" : ["ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
      },
      "Action" : "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name    = "EC2-IAM-Policy"
  role    = "${aws_iam_role.ec2_iam_role.id}"
  policy  = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "elasticloadbalancing:*",
        "cloudwatch:*",
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2-IAM-Instance-Profile"
  role = "${aws_iam_role.ec2_iam_role.name}"
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.key_pair_name}"
  public_key = "${file("test_ec2_key.pub")}"
}

resource "aws_launch_configuration" "ec2_private_launch_configuration" {
  image_id                    = "${var.instance_ami}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.key_pair_name}"
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  security_groups             = ["${aws_security_group.ec2_private_security_group.id}"]
  spot_price                  = "0.015"

  user_data = <<EOF
    #!/bin/bash
    apt update
    export INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
    echo "<html><body><h1>Hello from Test Backend at instance <b>"$INSTANCE_ID"</b></h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_autoscaling_group" "ec2_private_autoscaling_group" {
  name                = "Production-Backend-AutoScalingGroup"
  vpc_zone_identifier = [
    "${data.terraform_remote_state.network_configuration.private_subnet_1_id}",
    "${data.terraform_remote_state.network_configuration.private_subnet_2_id}"
  ]
  max_size              = "${var.max_instance_size}"
  min_size              = "${var.min_instance_size}"
  launch_configuration  = "${aws_launch_configuration.ec2_private_launch_configuration.name}"
  health_check_type     = "EC2"

  tag {
    key                 = "Name"
    propagate_at_launch = false
    value               = "Backend-EC2-Instance"
  }

  tag {
    key                 = "Type"
    propagate_at_launch = false
    value               = "Backend"
  }
}

resource "aws_autoscaling_policy" "webapp_production_scaling_policy" {
  autoscaling_group_name    = "${aws_autoscaling_group.ec2_private_autoscaling_group.name}"
  name                      = "Production-WebApp-AutoScaling-Policy"
  policy_type               = "TargetTrackingScaling"
  min_adjustment_magnitude  = 1

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}

resource "aws_security_group" "bastion_ssh_access" {
  name        = "bastion-ssh"
  description = "allows ssh access to the bastion host"
  vpc_id      = "${data.terraform_remote_state.network_configuration.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.bastion_instance_type}"
  key_name               = "${var.key_pair_name}"
  subnet_id              = "${data.terraform_remote_state.network_configuration.public_subnet_1_id}"
  vpc_security_group_ids = ["${aws_security_group.bastion_ssh_access.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type = "gp2"
    volume_size = "20"
  }

  tags {
    Name    = "bastion"
  }

  user_data = <<EOF
#!/bin/bash
apt update
EOF
}
