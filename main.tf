# Define the provider (AWS in this case)
provider "aws" {
  region = "us-east-1"  # You can adjust this based on your preferred region
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "172.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "cloud-demo-vpc"
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "cloud-demo-igw"
  }
}

# Create public subnets in multiple availability zones
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "172.30.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-demo-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "172.30.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-demo-public-subnet-2"
  }
}

# Create private subnets in multiple availability zones
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.30.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "cloud-demo-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.30.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "cloud-demo-private-subnet-2"
  }
}

# Create a route table for public subnets and associate with them
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "cloud-demo-public-rt"
  }
}

# Associate the route table with the public subnets
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
