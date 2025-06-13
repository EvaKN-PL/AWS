output "instance_id" {
  description = "ID instance EC2"
  value       = module.compute.instance_id
}

output "http_link_web" { 
  description = "Link to instance EC2"
  value = "http://${module.compute.public_ip}"
}