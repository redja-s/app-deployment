resource "aws_route_table" "igw_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_cidr_blocks)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.igw_rtb.id
}