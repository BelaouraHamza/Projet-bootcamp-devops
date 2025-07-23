output "docker_instance_id" {
  value = aws_instance.ec2_docker.id
}
output "docker_instance_name" {
  value = aws_instance.ec2_docker.tags["Name"]
}