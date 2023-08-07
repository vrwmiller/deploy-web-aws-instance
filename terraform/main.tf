terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "allow_www_sg1" {
  name        = "allow_www_sg1"
  description = "Allow inbound web traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags  = {
    Name = "allow_www_sg1"
  }
}

resource "aws_security_group" "allow_ssh_sg1" {
  name        = "allow_ssh_sg1"
  description = "Allow inbound ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.selfa, var.selfb ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_sg1"
  }
}

resource "aws_network_interface" "eni1" {
  subnet_id = "subnet-d64e26b2"
  security_groups = [
    "${aws_security_group.allow_www_sg1.id}",
    "${aws_security_group.allow_ssh_sg1.id}"
  ]

  attachment {
    instance      = aws_instance.web1.id
    device_index  = 1
  }
}

resource "aws_instance" "web1" {
  ami           = "${data.aws_ami.latest-amzn2.id}"
  instance_type = "t2.micro"
  key_name      = var.keyname
  availability_zone = "us-east-1a"

  tags = {
    Name = var.instance_name
  }
}

data "aws_ami" "latest-amzn2" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "al2023-ami" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
