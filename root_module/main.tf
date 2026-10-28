terraform {

  #Assumes s3 bucket and dynamodb table already created 
  backend "s3" {
   bucket = "projectsphere-storage"
   key = "terraform/root/terraform.tfstate"
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

module "console" {
  source           = "git::https://github.com/mohamedabdirazak848-spec/Terraform.git"
  environment_name = terraform.workspace
}


output "name_servers" {
  value = module.console.name_servers
}

output "url" {
  value = module.console.domain_url
}
