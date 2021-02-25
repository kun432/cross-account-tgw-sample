variable "vpc_id" {}
variable "private_subnet_ids" {}
variable "private_rtb_id" {}
variable "user_account" {}
variable "user_cidr" {}

resource "aws_ec2_transit_gateway" "tgw" {
  dns_support                     = "enable"
  vpn_ecmp_support                = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  auto_accept_shared_attachments  = "enable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.vpc_id
  subnet_ids         = var.private_subnet_ids
  dns_support        = "enable"
}

resource "aws_ram_resource_share" "tgw" {
  name = "tgw"
  allow_external_principals = true
  tags = {
    Name = "tgw"
  }
}

resource "aws_ram_resource_association" "tgw" {
  resource_arn       = aws_ec2_transit_gateway.tgw.arn
  resource_share_arn = aws_ram_resource_share.tgw.arn
}

resource "aws_ram_principal_association" "tgw" {
  principal          = var.user_account
  resource_share_arn = aws_ram_resource_share.tgw.arn
}

resource "aws_route" "route_tgw" {
  route_table_id         = var.private_rtb_id
  destination_cidr_block = var.user_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}
