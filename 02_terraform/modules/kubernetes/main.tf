resource "aws_instance" "ec2_kubernetes" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = [var.security_group_name]
    vpc_security_group_ids = [var.security_group_id]

    root_block_device {
        volume_size = "20"
        volume_type = "gp2"
        encrypted = true
        delete_on_termination = true
    }
    provisioner "remote-exec" {
      connection {
        type = "ssh"
        user = var.username
        private_key = var.private_key_content   

        host = self.public_ip
      }

      script = "./scripts/kubernetes.sh"
    }
    provisioner "local-exec" {
      command = "echo Kubernetes installed on ${self.public_ip} >> ip\\kubernetes_ip.txt"
    }

    tags = {
      Name = "${var.instance_name}-kubernetes"
    }
}