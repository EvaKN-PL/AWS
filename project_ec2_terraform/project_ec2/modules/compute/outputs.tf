output "public_ip" {
    description = "Public IP of instance"
    value = aws_instance.web.public_ip
}

output "instance_id" {
  description = "ID instance EC2"
  value       = aws_instance.web.id
}

output "main_subnet_id" {
  description = "Subnet ID"
  value = var.subnet_id
}

