output "main_subnet_id" {
  description = "ID of the main subnet"
  value       = aws_subnet.main_subnet.id
}

output "main_vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main_vpc.id
}
