variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "remote_state_bucket" {
  description = "Bucket name for layer 1 remote state"
}

variable "remote_state_key" {
  description = "Key name for layer 1 remote state"
}

variable "bastion_instance_type" {
  default     = "t2.micro"
  description = "EC2 Instance type to launch"
}

variable "ec2_instance_type" {
  description = "EC2 Instance type to launch"
}

variable "key_pair_name" {
  default     = "myEC2Keypair"
  description = "Keypair to use to connect to EC2 Instances"
}

variable "instance_ami" {
  description = "AMI to launch"
}

variable "max_instance_size" {
  description = "Maximum number of instances to launch"
}

variable "min_instance_size" {
  description = "Minimum number of instances to launch"
}