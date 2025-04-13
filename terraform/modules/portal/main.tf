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

resource "duplocloud_admin_system_setting" "enable_vpn" {
  key   = "EnableVPN"
  value = "true"
  type  = "Flags"
}
