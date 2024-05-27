variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the EC2 instances"
  type        = string
}

variable "name" {
  description = "The name prefix for the EC2 instances"
  type        = string
}
