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

data "aws_region" "current" {}

resource "duplocloud_infrastructure" "this" {
  address_prefix    = var.vpc_cidr
  azcount           = 2
  cloud             = 0 // AWS
  enable_k8_cluster = true
  infra_name        = var.short_name
  region            = var.region == "" ? data.aws_region.current.name : var.region
  subnet_cidr       = 22
}

resource "duplocloud_infrastructure_setting" "this" {
  delete_unspecified_settings = false
  infra_name                  = duplocloud_infrastructure.this.infra_name

  setting {
    key   = "EksEndpointVisibility"
    value = "private"
  }
  setting {
    key   = "EksControlplaneLogs"
    value = "api;audit;authenticator;controllerManager;scheduler"
  }
  setting {
    key   = "EnableDefaultEbsEncryption"
    value = true
  }
  setting {
    key   = "EnableClusterAutoscaler"
    value = true
  }
  setting {
    key   = "EnableAwsAlbIngress"
    value = true
  }
}

data "duplocloud_plan" "this" {
  plan_id = duplocloud_infrastructure.this.infra_name
}

resource "duplocloud_plan_certificates" "this" {
  plan_id = data.duplocloud_plan.this.id

  dynamic "certificate" {
    for_each = var.certificates
    content {
      id   = certificate.value
      name = certificate.key
    }
  }
}
