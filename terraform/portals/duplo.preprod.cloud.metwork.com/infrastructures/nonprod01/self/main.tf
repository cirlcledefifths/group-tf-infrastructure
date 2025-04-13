terraform {
  backend "s3" {
    # This backend config requires AWS credentials to be set in the environment. We can't interpolate outputs from the
    # duplocloud_admin_aws_credentials data source here.
    bucket         = "duplo-tfstate-975050254173"
    dynamodb_table = "duplo-tfstate-975050254173-lock"
    encrypt        = true
    key            = "portals/duplo.preprod.cloud.metwork.com/infrastructures/nonprod01/self/terraform.tfstate"
    region         = "us-east-2" # This will always be the region where Duplo runs.
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63.0"
    }
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = "~> 0.10.0"
    }
  }
  required_version = "~> v1.9.0"
}

provider "duplocloud" {
  duplo_host = "https://duplo.preprod.cloud.metwork.com"
}

data "duplocloud_admin_aws_credentials" "current" {}

provider "aws" {
  # This configures the AWS provider with credentials granted via your DUPLO_TOKEN environment variable.
  access_key = data.duplocloud_admin_aws_credentials.current.access_key_id
  region     = "us-east-2" # This should be the region where resources are created (which may not match the portal's).
  secret_key = data.duplocloud_admin_aws_credentials.current.secret_access_key
  token      = data.duplocloud_admin_aws_credentials.current.session_token
}
