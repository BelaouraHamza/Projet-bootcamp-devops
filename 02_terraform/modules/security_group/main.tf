resource "aws_security_group" "security_group" {
    name =  var.security_group_name
    vpc_id = var.vpc_id
    description = "Security group for EC2 Docker instance"

    dynamic "ingress" {
        for_each = var.security_group_ports
        content {
            protocol = var.protocol
            from_port = ingress.value
            to_port = ingress.value
            cidr_blocks = var.cidr_blocks
        }
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.security_group_name
    }
}