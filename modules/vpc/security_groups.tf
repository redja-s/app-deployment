//Public subnet SG
resource "aws_security_group" "public_app_sg" {
  name        = var.public_app_sg_name
  description = "Security Group for app instances"
  vpc_id      = aws_vpc.dev_vpc.id

  tags = {
    Name = var.public_app_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_allow_http" {
  security_group_id = aws_security_group.public_app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_ephemeral" {
  security_group_id = aws_security_group.public_app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 65535
  ip_protocol = "tcp"
}