// Public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }

  tags = {
    Name = var.public_rtb_name
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_cidr_blocks)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_rtb.id
}

// Private subnets
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = var.private_rtb_name
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_cidr_blocks)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_rtb.id
}