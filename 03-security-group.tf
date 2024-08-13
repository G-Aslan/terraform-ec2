module "security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.prefix}-sg"
  description = "Security group for web-server with HTTP ports open for ALB"
  vpc_id      = module.vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Port 80 from ALB SG"
      source_security_group_id = module.alb.security_group_id
    }
  ]
}