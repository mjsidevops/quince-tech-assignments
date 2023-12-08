variable "public_cidr" {
  default = {
    subnet1 = "10.0.1.0/24"
    subnet2 = "10.0.2.0/24"
  }
}

variable "private_cidr" {
  default = {
    subnet1 = "10.0.3.0/24"
    subnet2 = "10.0.4.0/24"
  }
}


variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az_us_west_2a" {
  default = "us-west-2a"
}

variable "az_us_west_2b" {
  default = "us-west-2b"
}

variable "ami" {
  default = "ami235235jbjsfvdfb"
}

variable "instanceType" {
  default = "t3_micro"
}

variable "keyName" {
  description = "key name for the ec2 instance"
}

variable "bucket_name" {
 default = "sample-bucket-name"
}
