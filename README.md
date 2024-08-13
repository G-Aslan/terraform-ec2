This project involves setting up the following AWS resources:

Resources:

- VPC.
- 2 Subnets - 1 Private subnet, 1 Public subnet, and route tables.
- Internet Gateway.
- Security Groups - for ALB and EC2.
- Application Load Balancer - Internet-facing (public subnets).
- CloudFront and WAF – Internet-facing. The WAF will only approve internat traffic from my office and from my home.
- EC2, Lambda, and SNS – private subnet.
- Build a "Hello World" web application (like NGINX) on the EC2.

Lambda and SNS:

Build a lambda that alerts when the EC2 is running for over 9 hours and shuts it down. The Lambda will be triggered every hour.

Use SNS to let the team know when the EC2 is running for over 9 hours.
