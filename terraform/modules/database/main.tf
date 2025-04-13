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
  }
  required_version = ">= v1.9.0"
}

data "duplocloud_tenant" "this" {
  name = local.tenant_name
}

data "duplocloud_tenant_aws_kms_key" "this" {
  tenant_id = local.tenant_id
}

locals {
  tenant_id          = data.duplocloud_tenant.this.id
  tenant_kms_key_arn = data.duplocloud_tenant_aws_kms_key.this.key_arn
  tenant_name        = var.tenant_name
}
