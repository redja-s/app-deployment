// VPC Variables
variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

// Public subnet variables
variable "public_cidr_blocks" {
  type        = list(string)
  description = "CIDR values for Public Subnet"
}

variable "public_subnet_name" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "public_app_sg_name" {
  type = string
}

// Private Subnet variables
variable "private_cidr_blocks" {
  type        = list(string)
  description = "CIDR values for Private Subnet"
}

variable "private_subnet_name" {
  type = string
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}