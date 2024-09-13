output "ec2_ip" {
  value = aws_instance.tf_ec2.public_ip
}
output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}