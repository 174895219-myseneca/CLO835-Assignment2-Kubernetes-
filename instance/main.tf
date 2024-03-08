
provider "aws" {
  region = "us-east-1"
}


# Define an ECR repository
resource "aws_ecr_repository" "ecr_assignment1" {
  name                 = "clo835-assignment1-ecr" # Name your repository
  image_tag_mutability = "MUTABLE"
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_instance" "my_amazon" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.week8_assignment1.key_name
  subnet_id                   = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web_sg.id]
  # iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  iam_instance_profile        = "LabInstanceProfile"
  user_data                   = file("${path.module}/install_docker.sh")
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EC2-Web-Application"
    }
  )
}


resource "aws_key_pair" "week8_assignment1" {
  key_name   = "week8_assignment1"
  public_key = file("week8.pub")
}
