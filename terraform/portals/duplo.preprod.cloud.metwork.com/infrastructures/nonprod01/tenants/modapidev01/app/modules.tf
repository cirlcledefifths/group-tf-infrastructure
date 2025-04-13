module "app" {
  source = "../../../../../../../modules/app"

  tenant_name = local.tenant_name
}
