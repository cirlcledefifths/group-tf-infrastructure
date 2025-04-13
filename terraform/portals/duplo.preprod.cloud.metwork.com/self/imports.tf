# These import blocks bring UI-created resources into the terraform state.
# They don't have to be kept after they complete their imports, but keeping them gives a nice historical record of what
# was created by terraform vs what was imported.
import {
  to = module.portal.duplocloud_admin_system_setting.enable_vpn
  id = "Flags/EnableVPN"
}
