module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.10.0"

  name                       = "${local.prefix}-alb"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all_outbound = {
      ip_protocol = "-1"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  target_groups = {
    ex-instance = {
      name        = "${local.prefix}-tg"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
      target_id   = module.ec2.id
    }
  }
}