provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr_block        = var.vpc_cidr_block
  subnet_cidr_block_az1 = var.subnet_cidr_block_az1
  subnet_cidr_block_az2 = var.subnet_cidr_block_az2
  availability_zone_az1 = var.availability_zone_az1
  availability_zone_az2 = var.availability_zone_az2
}

module "rds" {
  source               = "./modules/rds"
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.identifier
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  publicly_accessible  = var.publicly_accessible
  subnet_ids           = module.vpc.subnet_ids
  security_group_id    = module.vpc.allow_postgres_sg_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_ids[0]
  security_group_id = module.vpc.allow_http_sg_id
  name              = "student-registration"
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source             = "./modules/ecs"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  security_group_id  = module.vpc.allow_http_sg_id
  ecr_repository_url = module.ecr.repository_url
  rds_endpoint       = module.rds.endpoint
  db_username        = var.db_username
  db_password        = var.db_password
  db_name            = var.db_name
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
}
