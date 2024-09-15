# Create S3 bucket for storing the Terraform state
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "cloud-demo-platform"  # Use the desired bucket name

  tags = {
    Name = "cloud-demo-platform"
  }
}

# Create DynamoDB table for state locking (optional)
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock"
  }
}
