module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.4.0"

  comment         = "CloudFront distribution for ALB"
  enabled         = true
  is_ipv6_enabled = true
  web_acl_id      = aws_wafv2_web_acl.waf.arn


  default_cache_behavior = {
    allowed_methods             = ["GET", "HEAD"]
    cached_methods              = ["GET", "HEAD"]
    target_origin_id            = "my-alb-origin"
    viewer_protocol_policy      = "allow-all"
    compress                    = true
    forward_query_string        = false
    min_ttl                     = 0
    default_ttl                 = 3600
    max_ttl                     = 86400
    lambda_function_association = []
  }

  origin = [
    {
      domain_name = module.alb.dns_name
      origin_id   = "my-alb-origin"
      custom_origin_config = {
        http_port                = 80
        https_port               = 80
        origin_protocol_policy   = "http-only"
        origin_ssl_protocols     = ["TLSv1.2"]
        origin_keepalive_timeout = 5
        origin_read_timeout      = 30
      }
    }
  ]
}
