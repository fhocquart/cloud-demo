# Security group for public instances (e.g., Application Load Balancer, Bastion host)
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-demo-public-sg"
  }
}

# Security group for private instances (e.g., EC2 servers)
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow SSH from the public subnet only (e.g., from the bastion host or ALB)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet_1.cidr_block, aws_subnet.public_subnet_2.cidr_block]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-demo-private-sg"
  }
}
