module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"

  name                        = "${local.prefix}-ec2"
  ami                         = "ami-0ae8f15ae66fe8cda"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  # Need to tag the instance so that the Lambda function will know who to stop
  tags = {
    Project = var.Project
  }
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.security-group.security_group_id]
  user_data              = <<-EOF
              #!/bin/bash
              sudo useradd -p $(openssl passwd -6 gilad) gilad -s /bin/bash
              sudo usermod -aG wheel gilad
              sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              sudo systemctl restart sshd
              
              # Install httpd
              sudo yum install -y httpd

              # Start and enable httpd service
              sudo systemctl start httpd
              sudo systemctl enable httpd

              # Create a "Hello, World!" web page
              echo "Hello, World!" | sudo tee /var/www/html/index.html
              EOF

}