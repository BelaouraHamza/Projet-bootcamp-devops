output "keypair_name" {
  value = aws_key_pair.keypair_project.key_name
}

output "private_key_path" {
  value = local_file.private_key_pem.filename
}

output "private_key_content" {
  value     = tls_private_key.tls_key.private_key_pem
  sensitive = true
}
