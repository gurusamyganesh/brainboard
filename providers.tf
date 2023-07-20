terraform {
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
    aws = {
      version = "= 4.65.0"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}
