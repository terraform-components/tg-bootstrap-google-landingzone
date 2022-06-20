resource "google_organization_policy" "skip_default_network_creation" {
  org_id     = var.org_id
  constraint = "constraints/compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}
