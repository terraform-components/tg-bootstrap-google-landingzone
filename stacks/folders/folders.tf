locals {
  org_root = "organizations/${var.org_id}"
}

resource "google_folder" "environments" {
  for_each     = var.environments
  display_name = each.value
  parent       = local.org_root
}
