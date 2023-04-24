// IGW in Public subnet
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}