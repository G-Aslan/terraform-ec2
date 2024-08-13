module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v4.0.2"

  name               = "${local.prefix}-vpc"
  cidr               = var.cidr
  azs                = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = true
}
