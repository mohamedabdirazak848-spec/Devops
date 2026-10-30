terraform {

  #Assumes s3 bucket and dynamodb table already created 
  backend "s3" {
    bucket       = "projectsphere-storage"
    key          = "terraform/root/terraform.tfstate"
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

data "terraform_remote_state" "global" {
  count   = terraform.workspace == "global" ? 0 : 1
  backend = "s3"
  config = {
    bucket = "projectsphere-storage"
    key    = "terraform.tfstate.d/global/terraform.tfstate"
    region = "eu-west-2"
  }
}


provider "aws" {
  region = "eu-west-2"
}

module "console" {
  source           = "git::https://github.com/mohamedabdirazak848-spec/Terraform.git"
  environment_name = terraform.workspace
  create_dns_zone  = terraform.workspace == "global"
  zone_id          = terraform.workspace == "global" ? null : data.terraform_remote_state.global[0].outputs.zone_id
}

output "name_servers" {
  value = module.console.name_servers
}

output "url" {
  value = module.console.domain_url
}
