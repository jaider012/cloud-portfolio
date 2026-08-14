variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "shortener"
}

variable "vpc_id" {
  description = "VPC id from the week2-vpc-lab outputs"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet ids (ALB) from week2-vpc-lab"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet ids (Fargate tasks) from week2-vpc-lab"
  type        = list(string)
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "database_url" {
  description = "Postgres connection string (RDS or Neon free tier)"
  type        = string
  sensitive   = true
}
