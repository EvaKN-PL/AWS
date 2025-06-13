resource "aws_security_group" "web_sg" {
    vpc_id = var.vpc_id
    name = "SG for web"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSecurityGroup"
  }
  
}

resource "aws_instance" "web" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = var.key_name
    associate_public_ip_address = true

    tags = {
      Name = "web-server"
    }
    
    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd 
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Hello from ${var.region}" > /var/www/html/index.html
                EOF 
  
}
