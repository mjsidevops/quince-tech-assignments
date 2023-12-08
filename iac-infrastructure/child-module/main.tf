resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each          = var.public_cidr
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.az_us_west_2a
  tags = {
    Name = "Public-${each.key}"
  }
}


resource "aws_subnet" "private_subnets" {
  for_each          = var.private_cidr
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.az_us_west_2b 
  tags = {
    Name = "Private-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MyIGW"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id   = aws_subnet.public_subnets[1].id
  tags = {
    Name = "NATGateway"
  }
}

resource "aws_eip" "nat_eip" {
  domain  = "vpc"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "public_associations" {
  subnet_id        = aws_subnet.public_subnets[*].id
  route_table_id   = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_associations" {
  subnet_id        = aws_subnet.private_subnets[*].id
  route_table_id   = aws_route_table.private_route_table.id
}


//IAM role creation
resource "aws_iam_role" "s3_access_role" {
  name = "S3AccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "S3AccessRole"
  }
}

//Creating IAM policy
resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3AccessPolicy"
  description = "Allow S3 Access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "s3:*",
      Resource = "*"
    }]
  })
}

//Attaching policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.s3_access_role.name
}


//EC2 instance creation
resource "aws_instance" "example_instance" {
  ami             = var.ami
  instance_type   = var.instanceType  
  key_name        = var.keyName   
  subnet_id       = aws_subnet.public_subnets[0].id
  security_groups = [aws_security_group.example_sg.id]
  iam_instance_profile = aws_iam_role.s3_access_role.name

  tags = {
    Name = "ExampleInstance"
  }
}


//Security group for EC2 instance
resource "aws_security_group" "example_sg" {
  name        = "ExampleSecurityGroup"
  description = "Allow SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere (insecure; restrict in production)
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (insecure; restrict in production)
  }

  tags = {
    Name = "ExampleSecurityGroup"
  }
}
