resource "random_password" "mypassword" {
  length  = 16
  special = false
}

resource "duplocloud_rds_instance" "pg" {
  tenant_id      = local.tenant_id
  name           = "modapidev01-rds-01"
  engine         = 9 # Aurora PostgreSQL DB engine
  engine_version = "16.4" # PostgreSQL DB engine version
  size           = "db.serverless"

  master_username = "associations1"
  master_password = random_password.mypassword.result

  encrypt_storage         = true
  backup_retention_period = 7
}

resource "duplocloud_rds_read_replica" "replica" {
  tenant_id          = duplocloud_rds_instance.pg.tenant_id
  name               = "modapidev01-rds-replica-01"
  size               = "db.t3.medium"
  cluster_identifier = duplocloud_rds_instance.pg.cluster_identifier
}
