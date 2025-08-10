resource "aws_vpc" "ansible_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.instance_name}-ansible-vpc"
  }

}


resource "aws_subnet" "ansible_subnet" {
  vpc_id            = aws_vpc.ansible_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.region

  tags = {
    Name = "${var.instance_name}-ansible-subnet"
  }
}