resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_tgw_attachment" {
  subnet_ids = [aws_subnet.private_subnet.*.id]
  transit_gateway_id = var.tgw_id
  vpc_id = aws_vpc.vpc.id
}

resource "aws_network_acl" "network_acl" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.network_acl_name
  }
}

resource "aws_network_acl_rule" "network_acl_rules" {
  for_each = var.network_acl_rules

  network_acl_id = aws_network_acl.network_acl.id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}
