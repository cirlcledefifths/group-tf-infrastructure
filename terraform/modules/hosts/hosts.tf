data "duplocloud_infrastructure" "this" {
  tenant_id = local.tenant_id
}

data "duplocloud_plan" "this" {
  plan_id = data.duplocloud_infrastructure.this.infra_name
}

data "duplocloud_native_host_image" "this" {
  tenant_id     = local.tenant_id
  is_kubernetes = true
}

locals {
  zones = data.duplocloud_plan.this.availability_zones
}

# Append a new suffix whenever the ASG is replaced so the replacement can be created without its name conflicting
# with the existing ASG.
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id#example-usage
resource "random_id" "asg_suffix" {
  byte_length = 8
  keepers = {
    ami_id   = data.duplocloud_native_host_image.this.image_id
    capacity = var.asg.capacity
  }
}

resource "duplocloud_asg_profile" "zone" {
  for_each = toset(slice(local.zones, 0, min(length(local.zones), var.asg.max_zones)))

  agent_platform        = 7 # Kubernetes
  allocated_public_ip   = false
  capacity              = random_id.asg_suffix.keepers.capacity
  cloud                 = 0 # AWS
  encrypt_disk          = true
  friendly_name         = "${each.key}-${random_id.asg_suffix.hex}"
  image_id              = random_id.asg_suffix.keepers.ami_id
  instance_count        = 1 # Starting value. Cluster Autoscaler will adjust this later.
  is_cluster_autoscaled = true
  max_instance_count    = var.asg.max_instance_count_per_zone
  min_instance_count    = var.asg.min_instance_count_per_zone
  tenant_id             = local.tenant_id
  zone                  = index(data.duplocloud_plan.this.availability_zones, each.key)

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      instance_count # Don't undo changes made by cluster autoscaler.
    ]
  }
}
