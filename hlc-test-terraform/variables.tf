variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "remote_state_bucket" {
  description = "Bucket name for remote state"
}

variable "remote_state_key" {
  description = "Key name for remote state"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
}

variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 CIDR"
}

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 CIDR"
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

