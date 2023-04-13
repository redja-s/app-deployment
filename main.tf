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

  cidr_block = "10.0.0.0/16"
}

module "ec2_launch_template" {
  source = "./modules/launch-template"

  
}
