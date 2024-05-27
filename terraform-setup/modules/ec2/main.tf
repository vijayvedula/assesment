resource "aws_instance" "frontend" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.name}-frontend"
  }
}

resource "aws_instance" "backend" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.name}-backend"
  }
}

output "instance_ids" {
  value = [aws_instance.frontend.id, aws_instance.backend.id]
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}
