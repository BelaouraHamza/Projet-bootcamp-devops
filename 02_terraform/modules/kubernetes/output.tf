output "name" {
  description = "The name of the EIP"
  value       = aws_instance.ec2_kubernetes.tags["Name"]
  
}
output "kubernetes_instance_id" {
  description = "The ID of the Kubernetes instance"
  value       = aws_instance.ec2_kubernetes.id
}