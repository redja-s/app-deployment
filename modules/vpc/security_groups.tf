//Public subnet SG
resource "aws_security_group" "public_app_sg" {
  name        = var.public_app_sg_name
  description = "Security Group for app instances"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = var.public_app_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_allow_http" {
  for_each = var.public_app_sg_ingress

  security_group_id = aws_security_group.public_app_sg.id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_ephemeral" {
  for_each = var.public_app_sg_egress

  security_group_id = aws_security_group.public_app_sg.id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}