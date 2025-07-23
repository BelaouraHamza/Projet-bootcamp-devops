resource "aws_eip" "eip" {
    instance = var.instance_id
    
    tags = {
        Name = "${var.instance_name}-eip"
    }
  
}