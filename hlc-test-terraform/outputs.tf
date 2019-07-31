output "vpc_id" {
  value = aws_vpc.test-vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.test-vpc.cidr_block
}

output "public_subnet_1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}
