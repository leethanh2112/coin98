terraform {
  backend "local" {
    path = "./tfstate/terraform.tfstate"
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
