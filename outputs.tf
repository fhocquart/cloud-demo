# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main_igw.id
}

# Output the Public Subnet IDs
output "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.public_subnet_2.id
}

# Output the Private Subnet IDs
output "private_subnet_1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.private_subnet_2.id
}

# Output the Route Table ID for the public subnets
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}

# Output the Public EC2 Instance Public IP
output "public_ec2_public_ip" {
  description = "The public IP of the public EC2 instance"
  value       = aws_instance.public_ec2.public_ip
}

# Output the Public EC2 Instance Private IP
output "public_ec2_private_ip" {
  description = "The private IP of the public EC2 instance"
  value       = aws_instance.public_ec2.private_ip
}

# Output the Private EC2 Instance Private IP
output "private_ec2_private_ip" {
  description = "The private IP of the private EC2 instance"
  value       = aws_instance.private_ec2.private_ip
}
