variable "ami" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "vpc_security_group_ids" { type = list(string) }
variable "username" { type = string }
variable "private_key_path" { type = string }
variable "instance_name" { type = string }
variable "security_group_name" {type = string}