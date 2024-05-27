variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block_az1" {
  description = "CIDR block for subnet in AZ1"
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_block_az2" {
  description = "CIDR block for subnet in AZ2"
  default     = "10.0.2.0/24"
}

variable "availability_zone_az1" {
  description = "Availability Zone 1"
  default     = "us-west-2a"
}

variable "availability_zone_az2" {
  description = "Availability Zone 2"
  default     = "us-west-2b"
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
  default     = 20
}

variable "engine" {
  description = "The database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "13.14"
}

variable "instance_class" {
  description = "The instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = "myusername"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = "mypassword"
}

variable "parameter_group_name" {
  description = "The parameter group name"
  type        = string
  default     = "default.postgres12"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the instance is publicly accessible"
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
  default     = "ami-08c3f791b55fe9c86"
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "mydatabase"
}
