output "security_group_name" {
  value = aws_security_group.security_group.name
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "security_group_vpc_id" {
  value = aws_security_group.security_group.vpc_id
}