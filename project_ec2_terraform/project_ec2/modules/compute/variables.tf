variable "region" {
  description = "AWS Region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type = string
}

variable "instance_type" {
  description = "Type of instance"
  type = string
}

variable "subnet_id" {
    description = "ID of subnet"
    type = string
}

variable "vpc_id" {
    description = "ID of VPC"
    type = string
}

variable "key_name" {
  description = "Key for SSH"
  type = string
  
}
