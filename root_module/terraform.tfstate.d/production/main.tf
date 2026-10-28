terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend

  backend "s3" {

    bucket       = "projectsphere-storage"
    key          = "terraform.tfstate.d/global/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
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
# resource "aws_route53_zone" "primary" {
#   name = "projectsphere.dev"
# }

# variable "db_pass" {
#   description = "password for database"
#   type        = string
#   sensitive   = true
# }

locals {
  environment_name = "production"
}

module "web_app" {
  source = "git::https://github.com/mohamedabdirazak848-spec/Terraform.git"


  # Input Variables

  # bucket_name       = "projectsphere-storage-${local.environment_name}"
  domain            = "projectsphere.dev"
  environment_name  = local.environment_name
  ec2_instance_type = "t3.micro"
  create_dns_zone   = false
  # db_name           = "${local.environment_name}mydb"
  # db_user           = "foo"
  # db_pass           = var.db_pass
}