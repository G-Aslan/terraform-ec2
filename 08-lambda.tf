module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "ec2-running-check"
  description   = "Check if EC2 instance has been running for more than 9 hours and shut it down."

  handler     = "lambda_function.lambda_handler"
  runtime     = "python3.12"
  source_path = "./lambda_function.py"


  environment_variables = {
    SNS_TOPIC_ARN = module.sns_topic.topic_arn
  }

  timeout            = 600
  create_role        = true
  number_of_policies = 2
  attach_policies    = true
  policies = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  ]
}

# Allow Lambda to publish to SNS
resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = module.sns_topic.topic_arn
}