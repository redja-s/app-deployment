// Public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    for_each   = var.public_rtb_routes
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
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.private_rtb_name
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_cidr_blocks)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_rtb.id
}