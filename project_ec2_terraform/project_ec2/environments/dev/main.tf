provider "aws" {
    region = var.region
  
}

module "network" {
    source = "../../modules/network"
    vpc_cidr = var.vpc_cidr
    subnet_cidr =var.subnet_cidr

}

module "compute" {
  source = "../../modules/compute"
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.network.main_subnet_id
  vpc_id = module.network.main_vpc_id
  key_name = var.key_name
  region = var.region
}
  

