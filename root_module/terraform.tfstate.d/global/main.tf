terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend

  backend "s3" {

      bucket = "projectsphere-storage"
      key  = "terraform/global/terraform.tfstate"
      region = "eu-west-2"
      use_lockfile = true
      encrypt = true
      }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

# Route53 zone is shared across staging and production
resource "aws_route53_zone" "primary" {
  name = "projectsphere.dev"
}