variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "The Availability Zone to deploy the instance in"
  type        = string
  default     = "us-west-2a"
}

variable "vpc_cidr" {
  description = "The cidr block of VPC"
  type        = string
  default     = "10.123.0.0/16"

}

variable "subnet_cidr" {
  description = "The cidr block of Subnet"
  type        = string
  default     = "10.123.1.0/24"

}

