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

locals {
  tenant_id   = data.duplocloud_tenant.this.id
  tenant_name = var.tenant_name
}

resource "duplocloud_duplo_service" "nginx" {
  tenant_id = local.tenant_id

  name           = "nginx"
  agent_platform = 7 # Duplo EKS container agent
  docker_image   = "nginx:latest"
  replicas       = 1

  other_docker_config = jsonencode({
    Resources = {
      requests = {
        cpu    = "200m"
        memory = "200Mi"
      },
      limits = {
        cpu    = "300m"
        memory = "300Mi"
      }
    }
  })
}

resource "duplocloud_duplo_service" "nginx2" {
  tenant_id = local.tenant_id

  name           = "nginx2"
  agent_platform = 7 # Duplo EKS container agent
  docker_image   = "nginx:latest"
  replicas       = 1

  other_docker_config = jsonencode({
    Resources = {
      requests = {
        cpu    = "200m"
        memory = "100Mi"
      },
      limits = {
        cpu    = "300m"
        memory = "300Mi"
      }
    }
  })
}
