terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "infra/terraform.tfstate"
    bucket         = "bhisawlah2-terraform-backend-bucket"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locking"
  }
}
