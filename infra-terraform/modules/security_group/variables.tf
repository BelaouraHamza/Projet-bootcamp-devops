variable "security_group_name" {
  description = "The name of the security group"
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

variable "cidr_blocks" {
  description = "List of CIDR blocks for the security group rules"
  type        = list(string)
  default     = [ "0.0.0.0/0" ]
}
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}