module "tenant" {
  source = "../../../../../../../modules/tenant"

  infrastructure_name = "nonprod01"
  tenant_name         = "modapidev01"
}
