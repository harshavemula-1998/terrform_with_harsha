variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "availability_zone" {
  description = "The Availability Zone to deploy the instance in"
  type        = string
  default     = "us-east-1a"
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 1
}
