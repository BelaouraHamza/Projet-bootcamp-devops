resource "aws_instance" "ec2_ansible" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
 
  tags = {
    Name = "${var.instance_name}-ansible"
  }
}
