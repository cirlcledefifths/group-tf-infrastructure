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

resource "duplocloud_tenant" "this" {
  account_name   = var.tenant_name
  allow_deletion = false
  plan_id        = var.infrastructure_name
}

data "aws_cloudformation_stack" "openvpn" {
  name = "duplo-openvpn-v1" # This naming convention is enforced by the Duplo portal.
}

locals {
  tenant_id      = duplocloud_tenant.this.tenant_id
  vpn_private_ip = data.aws_cloudformation_stack.openvpn.outputs["PrivateIp"]
}

resource "duplocloud_tenant_network_security_rule" "postgres_over_vpn" {
  description    = "postgres-over-vpn"
  from_port      = 5432
  protocol       = "tcp"
  source_address = "${local.vpn_private_ip}/32"
  tenant_id      = local.tenant_id
  to_port        = 5432
}
