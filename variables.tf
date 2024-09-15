# # Define the region as a variable
# variable "aws_region" {
#   description = "The AWS region to create resources in"
#   default     = "us-east-1"
# }

# Define the CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "172.30.0.0/16"
}

# Define CIDR blocks for the public subnets
variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  default     = "172.30.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  default     = "172.30.2.0/24"
}

# Define CIDR blocks for the private subnets
variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  default     = "172.30.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  default     = "172.30.4.0/24"
}

# Define the availability zones to use
variable "availability_zone_1" {
  description = "The first availability zone"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "The second availability zone"
  default     = "us-east-1b"
}
