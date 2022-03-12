terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }
  }

  required_version = ">= 1.0.0, < 1.1.0"
}