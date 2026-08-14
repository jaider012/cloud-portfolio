terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.58"
    }
  }

  # Remote state: terraform init -backend-config=backend.hcl
  # (see ../../bootstrap for the bucket + lock table)
  backend "s3" {}
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "cloud-portfolio"
      Stack     = "week2-vpc-lab"
      ManagedBy = "terraform"
    }
  }
}

module "network" {
  source = "../../modules/network"

  name             = var.name
  vpc_cidr         = var.vpc_cidr
  az_count         = 2
  nat_per_az       = false # lab: single NAT; flip to true for production HA
  enable_flow_logs = true
}

# ---------- Private EC2 instance, reachable only via SSM ----------

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_security_group" "private_instance" {
  name        = "${var.name}-private-instance"
  description = "No inbound; outbound HTTPS only (SSM + package repos)"
  vpc_id      = module.network.vpc_id

  # SSM endpoints sit behind rotating AWS IPs, so 443 egress cannot be
  # narrowed to a CIDR; VPC endpoints would remove this (see ADR 0003).
  #trivy:ignore:AVD-AWS-0104
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-private-instance-sg" }
}

resource "aws_iam_role" "ssm" {
  name = "${var.name}-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.name}-ssm-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_instance" "private" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  subnet_id              = module.network.private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.private_instance.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm.name

  metadata_options {
    http_tokens = "required" # IMDSv2 only
  }

  root_block_device {
    encrypted = true
  }

  tags = { Name = "${var.name}-private-instance" }
}
