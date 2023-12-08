variable "public_cidr" {
  type = string
  description = "cidr for public subnets"
}

variable "private_cidr" {
  type = string
  description = "cidr for private subnets"
}


variable "vpc_cidr" {
  type = string
  description = "VPC cidr block"
}

variable "az_us_west_2a" {
  type = string
}

variable "az_us_west_2b" {
  type = string
}

variable "ami" {
  type = string
}

variable "instanceType" {
  type = string
  description = "instance type for ec2 instance"
}

variable "keyname" {
  type = string
  description = "key name for the ec2 instance"
}

variable "aws_region" {
  type = string
}