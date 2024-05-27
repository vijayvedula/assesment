resource "aws_ecs_cluster" "main" {
  name = "student-registration-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "student-registration-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "student-registration-backend"
      image     = "${var.ecr_repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      environment = [
        {
          name  = "DSN"
          value = "host=${var.rds_endpoint} user=${var.db_username} password=${var.db_password} dbname=${var.db_name} port=5432 sslmode=disable"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "main" {
  name            = "student-registration-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  launch_type = "FARGATE"
}

output "cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "service_name" {
  value = aws_ecs_service.main.name
}
