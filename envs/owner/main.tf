module "provider" {
  source = "../../modules/provider"
}

module "vpc" {
  source = "../../modules/vpc"
  stage  = var.stage
  vpc_cidr  = var.vpc_cidr
}

module "transit-gateway-owner" {
  source = "../../modules/transit-gateway-owner"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  private_rtb_id = module.vpc.private_route_table_id
  user_account = var.user_account
  user_cidr = var.user_vpc_cidr
}
module "security-groups" {
  source = "../../modules/security-groups"
  stage  = var.stage
  vpc_id = module.vpc.vpc_id
  vpc_cidr  = var.vpc_cidr
  other_vpc_cidr  = var.user_vpc_cidr
}
module "ssm" {
  source = "../../modules/ssm"
  vpc_id = module.vpc.vpc_id
  sg_id = module.security-groups.sg_id
  private_subnet_ids = module.vpc.private_subnet_ids
}