variable "vpc_id" {}
variable "private_subnet_ids" {}
variable "private_rtb_id" {}
variable "owner_account" {}
variable "owner_cidr" {}

data "aws_ec2_transit_gateway" "tgw" {
  filter {
    name   = "owner-id"
    values = [var.owner_account]
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  vpc_id             = var.vpc_id
  subnet_ids         = var.private_subnet_ids
  transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  dns_support        = "enable"
}

resource "aws_route" "route_tgw" {
  route_table_id         = var.private_rtb_id
  destination_cidr_block = var.owner_cidr
  transit_gateway_id     = data.aws_ec2_transit_gateway.tgw.id
}
