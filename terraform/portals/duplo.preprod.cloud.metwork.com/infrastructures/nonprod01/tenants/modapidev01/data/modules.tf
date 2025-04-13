# Technically the hosts don't contain data. But, they are slow to create and are often easier to update independently of
# other compute resources (e.g. when new AMIs are released with new patches). It's convenient to keep them in a root
# module that's usually deployed before the app module. This is an organizational compromise. There are other options.
module "hosts" {
  source = "../../../../../../../modules/hosts"

  asg = {
    capacity                    = "t3a.small"
    max_zones                   = 1
    max_instance_count_per_zone = 1
    min_instance_count_per_zone = 1
  }
  tenant_name = local.tenant_name
}

# Commented out for costs savings in the demo.
module "database" {
  source = "../../../../../../../modules/database"

  allocated_storage       = 10
  backup_retention_period = 1
  engine_version          = "16.4" # PostgreSQL DB engine version
  multi_az                = false
  size                    = "db.t4g.medium"
  storage_type            = "gp3"
  tenant_name             = local.tenant_name
}
