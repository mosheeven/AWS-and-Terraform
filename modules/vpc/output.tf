output "vpc_vpc_id" {
  description = "ARN of the bucket"
  value       = aws_vpc.main.id
}

output "private_subnet_vpc_ids" {
  description = "Name (id) of the bucket"
  value       = aws_subnet.private_moshe.*.id
}

output "public_subnet_vpc_ids" {
  description = "Domain name of the bucket"
  value       = aws_subnet.public_moshe.*.id
}