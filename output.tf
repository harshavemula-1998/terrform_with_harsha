output "ec2_ip" {
  value = aws_instance.tf_ec2.public_ip
}