// VPC Variables
variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "network_acl_name" {
  type = string
}

variable "network_acl_rules" {
  type = map(object(
    {
      rule_number = number
      egress = bool
      protocol = string
      rule_action = string
      cidr_block = string
      from_port = number
      to_port = number
    }
  ))
}

variable "tgw_id" {
  type = string
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

variable "public_rtb_name" {
  type = string
  description = "Name of public route table to associate with public subnets"
}

variable "public_rtb_routes" {
  type = map(any)
}

variable "public_app_sg_name" {
  type = string
}

variable "public_app_sg_ingress" {
  type = map(object(
    {
      cidr_ipv4 = string  
      from_port = number
      to_port = number
      ip_protocol = string
    }
  ))
}

variable "public_app_sg_egress" {
  type = map(object(
    {
      cidr_ipv4 = string  
      from_port = number
      to_port = number
      ip_protocol = string
    }
  ))
}

// Private Subnet variables
variable "private_cidr_blocks" {
  type        = list(string)
  description = "CIDR values for Private Subnet"
}

variable "private_subnet_name" {
  type = string
}

variable "private_rtb_name" {
  type = string
  description = "Name of public route table to associate with public subnets"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}