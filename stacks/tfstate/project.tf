resource "google_project" "self" {
  name            = "${var.namespace}-${var.environment}-tfstate"
  project_id      = "${var.namespace}-${var.environment}-tfstate"
  org_id          = var.org_id
  billing_account = var.billing_account
  skip_delete     = true
  labels          = local.labels
}
