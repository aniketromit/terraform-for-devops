terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
  backend "s3" {
    bucket = "my-tf-ani-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "my-tf-ani-state-table"
  }
}