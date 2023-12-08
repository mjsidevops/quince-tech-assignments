terraform {
  backend "s3" {
    bucket         = "test-bucket-name"
    key            = "terraformstate/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "test-db-table"
  }
}
