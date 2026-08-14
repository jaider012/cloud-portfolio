output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "private_instance_id" {
  description = "Connect with: aws ssm start-session --target <this id>"
  value       = aws_instance.private.id
}
