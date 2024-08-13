module "sns_topic" {
  source = "terraform-aws-modules/sns/aws"

  name = "ec2-running-too-long-alerts"

  subscriptions = {
    email_subscription = {
      protocol               = "email"
      endpoint               = var.sns-email
      endpoint_auto_confirms = true
    }
  }
}
