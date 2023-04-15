// Public subnet
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_cidr_blocks)
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = element(var.public_cidr_blocks, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

// Private subnet
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = element(var.private_cidr_blocks, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.private_subnet_name}-${count.index + 1}"
  }
}
