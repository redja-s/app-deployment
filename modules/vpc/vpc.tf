resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.dev_vpc
  cidr_block = var.private_cidr_block
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.dev_vpc
  cidr_block = var.private_cidr_block
}