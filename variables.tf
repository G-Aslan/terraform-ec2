variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

############## EC2 ##############
variable "ami" {
  description = "The AMI to use for the EC2 instance."
}

############## VPC ##############
variable "private_subnets" {
  description = "List of private subnets"
}
variable "public_subnets" {
  description = "List of public subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}
variable "sns-email" {
  description = "The SNS email endpoint"
}

variable "Project" {
  description = "Tag to mark the project associated with the instance"
  type        = string
  default     = "True"
}
