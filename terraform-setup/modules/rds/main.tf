resource "aws_db_parameter_group" "postgres_parameter_group" {
  name   = "custom-postgres13"
  family = "postgres13"

  parameter {
    name  = "max_connections"
    value = "100"
    apply_method = "pending-reboot"  # Use pending-reboot for static parameters
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.identifier
  username             = var.username
  password             = var.password
  parameter_group_name = aws_db_parameter_group.postgres_parameter_group.name
  skip_final_snapshot  = var.skip_final_snapshot
  publicly_accessible  = var.publicly_accessible
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  depends_on = [aws_db_subnet_group.rds_subnet_group]
}

output "endpoint" {
  value = aws_db_instance.postgres.endpoint
}
