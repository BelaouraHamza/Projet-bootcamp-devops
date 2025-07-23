output "instance_id" {
  value = aws_eip.eip.id
  
}

output "instance_name" {
  value = aws_eip.eip.tags["Name"]

}