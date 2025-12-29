provider "aws" {
  region = var.aws_region
}

# Security Group in default VPC
resource "aws_security_group" "jenkins_sg" {
  name        = var.security_group
  description = "security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group
  }
}

# First EC2 Instance in default VPC
resource "aws_instance" "myFirstInstance" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = var.tag_name
  }
}

# Elastic IP for first instance
resource "aws_eip" "myFirstInstance" {
  instance = aws_instance.myFirstInstance.id

  tags = {
    Name = "my_elastic_ip"
  }
}

# Second EC2 Instance in default VPC
resource "aws_instance" "mySecondInstance" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.tag_name}-2"
  }
}

# Elastic IP for second instance
resource "aws_eip" "mySecondInstance" {
  instance = aws_instance.mySecondInstance.id

  tags = {
    Name = "my_elastic_ip_2"
  }
}
