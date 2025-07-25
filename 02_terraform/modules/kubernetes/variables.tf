variable "ami" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "vpc_security_group_ids" { type = list(string) }
variable "username" { type = string }
variable "private_key_path" { type = string }
variable "instance_name" { type = string }
variable "private_key_content" { sensitive   = true}
variable"subnet_id" { type = string }
