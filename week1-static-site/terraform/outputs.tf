output "cloudfront_url" {
  description = "Site URL"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "bucket_name" {
  value = aws_s3_bucket.site.id
}
