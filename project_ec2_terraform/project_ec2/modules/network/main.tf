resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "main-vpc"
    }
  
}

resource "aws_subnet" "main_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = true

    tags = {
      Name = "MainSubnet"
    }
  
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main_vpc.id

    tags = {
      Name = "igw-web"
    }
}

resource "aws_route_table" "rt"{
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "rt-web"
    }
}

resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.rt.id
}
  


