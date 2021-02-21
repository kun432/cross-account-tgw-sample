module "provider" {
  source = "../../modules/provider"
}

module "vpc" {
  source = "../../modules/vpc"
  stage  = var.stage
  vpc_cidr  = var.vpc_cidr
}

module "transit-gateway-user" {
  source = "../../modules/transit-gateway-user"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  private_rtb_id = module.vpc.private_route_table_id
  owner_account = var.owner_account
  owner_cidr = var.owner_vpc_cidr
}