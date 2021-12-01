# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "project-5" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  #enable_dns_support   = "true"
 # enable_dns_hostnames = "true"
 # enable_classiclink   = "false"
  tags = {
    Name = "project-5"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "My-public-1" {
  vpc_id                  = aws_vpc.project-5.id
  cidr_block              = "10.0.1.0/24"
 # map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "My-public-1"
  }
}

resource "aws_subnet" "My-public-2" {
  vpc_id                  = aws_vpc.project-5.id
  cidr_block              = "10.0.2.0/24"
 #map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "My-public-2"
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "My-private-1" {
  vpc_id                  = aws_vpc.project-5.id
  cidr_block              = "10.0.3.0/24"
  #map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "My-private-1"
  }
}

resource "aws_subnet" "My-private-2" {
  vpc_id                  = aws_vpc.project-5.id
  cidr_block              = "10.0.4.0/24"
 # map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "My-private-2"
  }
}


# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "My-igw" {
  vpc_id = aws_vpc.project-5.id

  tags = {
    Name = "My-igw"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "My-public" {
  vpc_id = aws_vpc.project-5.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My-igw.id
  }

  tags = {
    Name = "My-public"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "My-public-1-a" {
  subnet_id      = aws_subnet.My-public-1.id
  route_table_id = aws_route_table.My-public.id
}

resource "aws_route_table_association" "My-public-2-a" {
  subnet_id      = aws_subnet.My-public-2.id
  route_table_id = aws_route_table.My-public.id
}