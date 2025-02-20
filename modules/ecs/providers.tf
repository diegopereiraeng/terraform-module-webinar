terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    harness = {
      source = "harness/harness"
      version = "0.35.5"
    }
  }
  backend "s3" {}
}

provider "harness" {
  account_id       = var.account_id
  platform_api_key = var.platform_api_key
}