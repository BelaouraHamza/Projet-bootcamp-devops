variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}
 variable "instance_name" {
  description = "The name of the instance"
  type        = string
   
 }
variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "username" {
  description = "The SSH username"
  type        = string
}

variable "security_group_ports" {
    description = "List of ports for the security group"
    type        = list(number)
}

variable "protocol" {
  description = "The protocol for the security group rules"
  type        = string
}
variable "stack" {
  description = "The name of the stack"
  type        = string
  
}

variable"region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}