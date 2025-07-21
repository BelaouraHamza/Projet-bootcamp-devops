resource "aws_key_pair" "keypair_project" {
    key_name   = var.key_name
    public_key = tls_private_key.tls_key.public_key_openssh
}

//Ce bloc est souvent utilisé pour :
//Pour du test/lab local	Génération de clés pour des environnements non prod, sans besoin d'importer des clés manuelles
resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key_pem" {
    filename = "${path.module}/${var.key_name}.pem"
    content = tls_private_key.tls_key.private_key_pem
    file_permission = "0400"
}