variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "region" {
  description = "The availability zone for the subnet"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
