terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.63.0"
    }
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
  required_version = ">= v1.9.0"
}

data "duplocloud_tenant" "this" {
  name = local.tenant_name
}

locals {
  tenant_id   = data.duplocloud_tenant.this.id
  tenant_name = var.tenant_name
}
