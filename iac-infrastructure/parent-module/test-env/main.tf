module "create_infra" {
  
source = "../../child-module"
public_cidr = var.public_cidr
private_cidr = var.private_cidr
vpc_cidr = var.vpc_cidr
az_us_west_2a = var.az_us_west_2a
az_us_west_2b = var.az_us_west_2b
ami = var.ami
instanceType = var.instanceType
keyName = var.keyname

}