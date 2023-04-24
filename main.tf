terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket = "state-bucket-292030"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name         = "Dev-VPC"
  vpc_cidr_block   = "10.0.0.0/16"
  tgw_id           = module.transit_gateway.tgw_id
  network_acl_name = "dev-nacl"

  network_acl_rules = {
    allow_80_http = {
      rule_number    = 100
      egress     = false
      protocol   = "tcp"
      rule_action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    }
  }

  public_subnet_name = "dev-public-subnet"
  public_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_app_sg_name = "dev-public-sg"
  public_rtb_name    = "dev-public-rt"

  public_app_sg_ingress = {
    allow_80_http = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
    }
  }

  public_app_sg_egress = {
    ephemeral_ports = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 0
      to_port     = 65535
      ip_protocol = "tcp"
    }
  }

  public_rtb_routes = {
    
  }

  private_subnet_name = "dev-private-subnet"
  private_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_rtb_name    = "dev-private-rt"

  internet_gateway_name = "dev-public-igw"
}

module "preprod_vpc" {
  source = "./modules/vpc"

  vpc_name         = "PreProd-VPC"
  vpc_cidr_block   = "172.17.0.0/16"
  tgw_id           = module.transit_gateway.tgw_id
  network_acl_name = "PreProd-nacl"

  network_acl_rules = {
    allow_80_http = {
      rule_number    = 100
      egress     = false
      protocol   = "tcp"
      rule_action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    }
  }

  public_subnet_name = "preprod-public-subnet"
  public_cidr_blocks = ["172.17.1.0/24", "172.17.2.0/24", "172.17.3.0/24"]
  public_app_sg_name = "preprod-public-sg"
  public_rtb_name    = "preprod-public-rt"
  public_app_sg_ingress = {
    allow_80_http = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
    }
  }

  public_app_sg_egress = {
    ephemeral_ports = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 0
      to_port     = 65535
      ip_protocol = "tcp"
    }
  }

  private_subnet_name = "preprod-private-subnet"
  private_cidr_blocks = ["172.17.4.0/24", "172.17.5.0/24", "172.17.6.0/24"]
  private_rtb_name    = "preprod-private-rt"

  internet_gateway_name = "preprod-public-igw"
}

module "transit_gateway" {
  source = "./modules/transit-gateway"

  tgw_name = "nprd-tgw"
}

module "ec2_launch_template" {
  source = "./modules/launch-template"

  launch_template_name = "test-launchtemplate"
  ami_id               = "ami-00aa9d3df94c6c354"
  instance_type        = "t2.micro"
}

module "s3_buckets" {
  source = "./modules/s3"

  logging_bucket_name       = "logging-bucket"
  logging_bucket_versioning = true
}