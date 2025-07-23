data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

locals {
  ami_id         = data.aws_ami.ubuntu.id
  filename       = "./modules/keypair/${var.stack}.pem"
  instance_name  = var.stack
}



module "keypair" {
  source           = "./modules/keypair"
  key_name         = var.stack
  public_key_path  = local.filename
  filename         = local.filename
}

module "security_group" {
  source                = "./modules/security_group"
  security_group_name   = var.security_group_name
  security_group_ports  = var.security_group_ports
  protocol              = var.protocol
  depends_on            = [module.keypair]
}

module "ec2_docker" {
  source              = "./modules/docker"
  instance_name       = local.instance_name
  ami                 = local.ami_id
  instance_type       = var.instance_type
  key_name            = var.stack
  security_group_name = module.security_group.security_group_name
  security_group_id   = module.security_group.security_group_id
  username            = var.username
  private_key_path    = module.keypair.private_key_path
  count               = var.stack == "docker" ? 1 : 0
}

module "ec2_kubernetes" {
  source              = "./modules/kubernetes"
  instance_name       = local.instance_name
  ami                 = local.ami_id
  instance_type       = var.instance_type
  key_name            = var.stack
  security_group_name = module.security_group.security_group_name
  security_group_id   = module.security_group.security_group_id
  username            = var.username
  private_key_path    = module.keypair.private_key_path
  private_key_content = module.keypair.private_key_content
  count               = var.stack == "kubernetes" ? 1 : 0
}


module "eip_ec2_docker" {
  source          = "./modules/eip"
  instance_id     = var.stack == "docker" ? module.ec2_docker[0].docker_instance_id : null
  instance_name   = local.instance_name
  count           = var.stack == "docker" ? 1 : 0
}

module "eip_ec2_kubernetes" {
  source          = "./modules/eip"
  instance_id     = var.stack == "kubernetes" ? module.ec2_kubernetes[0].kubernetes_instance_id : null
  instance_name   = local.instance_name
  count           = var.stack == "kubernetes" ? 1 : 0
}