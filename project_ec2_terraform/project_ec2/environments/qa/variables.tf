variable "ami_id" {
  description = "ID image AMI"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type = string
}

variable "subnet_cidr" {
  description = "CIDR for subnet"
  type = string  
}

variable "instance_type" {
  description = "type of instance"
  type = string
}

variable "region" {
    description = "Region AWS"
    type = string
  
}

variable "key_name" {
  description = "Key for SSH"
  type = string
}