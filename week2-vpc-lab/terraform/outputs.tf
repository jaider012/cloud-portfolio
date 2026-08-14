output "vpc_id" {
  value = aws_vpc.lab.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_instance_id" {
  description = "Connect with: aws ssm start-session --target <this id>"
  value       = aws_instance.private.id
}
