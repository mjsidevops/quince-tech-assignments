terraform {
  backend "s3" {
    bucket         = "dig-apitest-iac-state"
    key            = "iac-node-assembler/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "dig-iac-state-lock"
  }
}