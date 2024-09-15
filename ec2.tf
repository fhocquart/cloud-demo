# Fetch the latest Ubuntu AMI for the region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical's AWS account ID for Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create an EC2 instance in the public subnet
resource "aws_instance" "public_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "CM_keypair"

  subnet_id               = aws_subnet.public_subnet_1.id
  security_groups         = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  depends_on = [aws_security_group.public_sg]  # Ensure the security group is created first

  tags = {
    Name = "cloud-demo-public-instance"
  }
}

# Create an EC2 instance in the private subnet
resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "CM_keypair"

  subnet_id               = aws_subnet.private_subnet_1.id
  security_groups         = [aws_security_group.private_sg.id]
  associate_public_ip_address = true  # Enable public IP

  depends_on = [aws_security_group.private_sg]  # Ensure the security group is created first

  tags = {
    Name = "cloud-demo-private-instance"
  }
}
