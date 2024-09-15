terraform {
  backend "s3" {
    bucket         = "cloud-demo-platform"    # S3 bucket for storing the Terraform state
    key            = "terraform/state"        # Path inside the bucket where the state file will be stored
    region         = "us-east-1"              # AWS region where the bucket is located
    encrypt        = true                     # State file will be encrypted
    dynamodb_table = "terraform-lock"         # DynamoDB table for state locking
  }
}
