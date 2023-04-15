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

  vpc_name       = "Dev-VPC"
  vpc_cidr_block = "10.0.0.0/16"

  public_subnet_name = "public-subnet"
  public_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_app_sg_name = "public-app-security-group"

  private_subnet_name = "private-subnet"
  private_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  internet_gateway_name = "public-igw"
}

module "ec2_launch_template" {
  source = "./modules/launch-template"

  launch_template_name = "test-launchtemplate"
  ami_id               = "ami-03041c74989f76c04"
  instance_type        = "t2.micro"
}
