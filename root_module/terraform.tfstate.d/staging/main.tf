terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend

  # backend "s3" {

  #     bucket = "devops-directive-tf-state"
  #     key  = "07-managing-multiple-environments/global/terraform.tfstate"
  #     region = "eu-west-2"
  #     dynamodb_table = "terraform-state-locking"
  #     encrypt = true
  #     }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
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

#variable "db_pass" {
#    description = "password for database"
#    type = string
#    sensitive = true
#}

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "git@github.com:mohamedabdirazak848-spec/Terraform.git"

  # Input Variables

  domain           = "projectsphere.dev"
  environment_name = local.environment_name
  instance_type    = "t3.micro"
  create_dns_zone  = false
  #bucket_name = "devops-directive-web-app-data-${local.environment_name}"
  #db_name = "${local.environment_name}mydb"
  #db_user = "foo"
  #db_pass = var.db_pass
}