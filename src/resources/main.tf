terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # NÃO DA PRA USAR VARIAVEIS NESSE BLOCO DE CÓDIGO
  backend "s3" {
    bucket         = "tfstate-env-061764842972"
    key            = "pilot-workspaces/terraform.tfstate"
    region         = "us-east-1"
    profile        = "default"
    dynamodb_table = "tflock-tfstate-env-061764842972"
  }
}

provider "aws" {
  region  = lookup(var.aws_region, local.env)
  profile = var.aws_profile
}
