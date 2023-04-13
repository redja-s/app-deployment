# VPC Variables

variable "vpc_name" {
  type = string
  description = "Name of VPC"
}

variable "vpc_cidr_block" {
  type = string
  description = "CIDR block for the VPC"
}

variable "private_cidr_block" {
  type = string
}

variable "public_cidr_block" {
  type = string
}