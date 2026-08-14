variable "region" {
  description = "AWS region for the S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default     = "jaider012-portfolio-site"
}

variable "domain_name" {
  description = "Custom domain (leave empty to use the default CloudFront domain)"
  type        = string
  default     = ""
}
