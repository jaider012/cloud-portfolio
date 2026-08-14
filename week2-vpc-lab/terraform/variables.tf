variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  description = "Prefix for all resource names"
  type        = string
  default     = "vpclab"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
