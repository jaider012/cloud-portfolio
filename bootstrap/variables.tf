variable "region" {
  type    = string
  default = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique bucket for Terraform remote state"
  type        = string
  default     = "jaider012-tfstate"
}

variable "github_repo" {
  description = "owner/repo allowed to assume the deploy role via OIDC"
  type        = string
  default     = "jaider012/cloud-portfolio"
}

variable "site_bucket_name" {
  description = "Site bucket the deploy role may write to (week1 stack)"
  type        = string
  default     = "jaider012-portfolio-site"
}
