resource "aws_eip" "eip" {
    instance = var.instance_id

    vpc      = true
    
    tags = {
        Name = "${var.instance_name}-eip"
    }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.eip.id
}