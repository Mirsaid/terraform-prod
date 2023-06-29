variable region {
  type        = string
  default     = "eu-central-1"
  description = "Frankfurt region"
}

provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }


}