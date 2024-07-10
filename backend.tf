terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "infra/terraform.tfstate"
    bucket         = "terraform-lock-tableterraform"
    region         = "us-west-1"
    dynamodb_table = "terraform-state-locking"
  }
}
