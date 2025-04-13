module "tenant" {
  source = "../../../../../../../modules/tenant"

  infrastructure_name = "nonprod01"
  tenant_name         = "dev-01"
}
