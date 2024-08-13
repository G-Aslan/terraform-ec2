resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.alb.target_groups["ex-instance"].arn
  }

  depends_on = [module.alb]
}