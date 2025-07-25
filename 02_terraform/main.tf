data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

locals {
  ami_id        = data.aws_ami.ubuntu.id
  filename      = "./modules/keypair/${var.stack}.pem"
}

# Récupérer le VPC par défaut
data "aws_vpc" "default" {
  default = true
}

# Récupérer les subnets associés au VPC par défaut
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Récupérer un subnet précis (ex : le premier subnet)
data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}

# module "network" {
#   source        = "./modules/network"
#   vpc_cidr      = var.vpc_cidr
#   subnet_cidr   = var.subnet_cidr
#   instance_name = "${var.instance_name}-network"
#   region        = var.region
# }

module "keypair" {
  source          = "./modules/keypair"
  key_name        = var.stack
  public_key_path = local.filename
  filename        = local.filename
}

module "security_group" {
  source               = "./modules/security_group"
  security_group_name  = var.security_group_name
  security_group_ports = var.security_group_ports
  protocol             = var.protocol
  vpc_id               = data.aws_vpc.default.id
  depends_on           = [module.keypair]
}

# module "eip_ec2_docker" {
#   source        = "./modules/eip"
#   instance_id   = var.stack == "docker" ? module.ec2_docker[0].docker_instance_id : null
#   instance_name = local.instance_name
#   count         = var.stack == "docker" ? 1 : 0
# }

# module "eip_ec2_kubernetes" {
#   source        = "./modules/eip"
#   instance_id   = var.stack == "kubernetes" ? module.ec2_kubernetes[0].kubernetes_instance_id : null
#   instance_name = local.instance_name
#   count         = var.stack == "kubernetes" ? 1 : 0
# }


module "ec2_docker" {
  source                 = "./modules/docker"
  instance_name          = var.instance_name
  ami                    = local.ami_id
  instance_type          = var.instance_type
  key_name               = var.stack
  security_group_name    = module.security_group.security_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  username               = var.username
  private_key_path       = module.keypair.private_key_path
  count                  = var.stack == "docker" ? 1 : 0
}

module "ec2_kubernetes" {
  source                 = "./modules/kubernetes"
  instance_name          = var.kubernetes_instance_name
  ami                    = local.ami_id
  instance_type          = var.instance_type
  key_name               = var.stack
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = data.aws_subnet.default.id
  username               = var.username
  private_key_path       = module.keypair.private_key_path
  private_key_content    = module.keypair.private_key_content
  count                  = var.stack == "kubernetes" ? 1 : 0
  depends_on             = [module.security_group]
}

module "ec2_ansible" {
  source                 = "./modules/ansible"
  ami                    = local.ami_id
  instance_type          = var.instance_type
  key_name               = var.stack
  instance_name          = var.ansible_instance_name
  security_group_name    = module.security_group.security_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = data.aws_subnet.default.id
  depends_on = [
    module.security_group,
    module.keypair
  ]
}

