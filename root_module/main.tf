terraform {

  #Assumes s3 bucket and dynamodb table already created 
  #backend "s3" {
  #  bucket = "devops-directive-tf-state"
  #  key = "03-basics/webb-app/terraform.tfstate"
  #  region = "eu-west-2"
  #  dynamodb_table = "terraform-state-locking"
  #  encrypt = true
  #}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

module "console" {
  source = "git@github.com:mohamedabdirazak848-spec/Terraform.git"
}


output "name_servers" {
  value = module.console.name_servers
}

output "url" {
  value = module.console.domain_url
}
