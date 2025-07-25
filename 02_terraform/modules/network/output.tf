output "subnet_id" {
  value = aws_subnet.ansible_subnet.id
}
output "vpc_id" {
  value = aws_vpc.ansible_vpc.id
}