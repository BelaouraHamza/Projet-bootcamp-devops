resource "aws_instance" "ec2_docker" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.username
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
    script = "./scripts/docker.sh"
  }

  provisioner "local-exec" {
    command = "echo Docker installed on ${self.public_ip} >> ip\\docker_ip.txt"
  }


  tags = {
    Name = "${var.instance_name}-docker"
  }
}
