variable "allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
}

variable "engine" {
  description = "The database engine"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default = 13.14
}

variable "instance_class" {
  description = "The instance class"
  type        = string
}

variable "identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "The parameter group name"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the instance is publicly accessible"
  type        = bool
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the VPC security group"
  type        = string
}
