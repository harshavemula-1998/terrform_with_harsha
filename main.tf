resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_based"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "terraform_subnet"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_routetable" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "tf_routetable"
  }
}

resource "aws_route" "tf_route" {
  route_table_id         = aws_route_table.tf_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf_igw.id
}

resource "aws_route_table_association" "tf_route_assc" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.tf_routetable.id
}



resource "aws_security_group" "tf_secgrp" {

  name        = "tf_secgrp"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id
  tags = {
    Name = "tf_secgrp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_allow_tls_ipv4" {
  security_group_id = aws_security_group.tf_secgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = -1
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "tf_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tf_secgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_key_pair" "tfkey" {
  key_name   = "tf-key"
  public_key = file("~/.ssh/id_rsa")
}

resource "aws_instance" "tf_ec2" {
  availability_zone = "us-west-2"
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.tfkey.id
  tags = {
    name = "tf_ec2"
  }
  ami                    = data.aws_ami.ubuntu_bionic.id
  vpc_security_group_ids = [aws_security_group.tf_secgrp.id]
  subnet_id              = aws_subnet.terraform_subnet.id
  user_data = file("userdata.tpl")
}