variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block_az1" {
  description = "The CIDR block for the subnet in AZ1"
  type        = string
}

variable "subnet_cidr_block_az2" {
  description = "The CIDR block for the subnet in AZ2"
  type        = string
}

variable "availability_zone_az1" {
  description = "The availability zone for the subnet in AZ1"
  type        = string
}

variable "availability_zone_az2" {
  description = "The availability zone for the subnet in AZ2"
  type        = string
}
