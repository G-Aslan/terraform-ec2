# Create IP set
resource "aws_wafv2_ip_set" "waf" {
  name               = "${local.prefix}-waf"
  description        = "Only from Gilads home or CloudZone Office"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = ["89.138.15.89/32", "212.199.245.230/32"]
}

# Create Web ACL
resource "aws_wafv2_web_acl" "waf" {
  name        = "${local.prefix}-waf"
  description = "Protected by the basic WAF"
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "IPfilter"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.waf.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "IPfilter"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF"
    sampled_requests_enabled   = true
  }
}