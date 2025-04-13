# These import blocks bring UI-created resources into the terraform state.
# They don't have to be kept after they complete their imports, but keeping them gives a nice historical record of what
# was created by terraform vs what was imported.
import {
  to = module.infrastructure.duplocloud_infrastructure.this
  id = "v2/admin/InfrastructureV2/nonprod01"
}

import {
  to = module.infrastructure.duplocloud_infrastructure_setting.this
  id = "nonprod01"
}

import {
  to = module.infrastructure.duplocloud_plan_certificates.this
  id = "nonprod01"
}

# import {
#   to = module.infrastructure.duplocloud_plan_certificates.this["preprod.cloud.metwork.com-wildcard-us-east-2-ecdsa"]
#   id = "preprod.cloud.metwork.com-wildcard-us-east-2-ecdsa"
# }
