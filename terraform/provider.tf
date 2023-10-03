terraform {
  backend "s3" {
    profile = "coin98"
    bucket  = "coin98-terraform-backend"
    region  = "us-east-1"
    key     = "terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.63.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias  = "nvirginia"
  region = "us-east-1"
}
