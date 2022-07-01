resource "google_project" "project" {
  for_each            = toset(var.projects)
  name                = "${var.context}-${var.environment}-${each.key}"
  project_id          = "${var.context}-${var.environment}-${each.key}"
  folder_id           = var.folder
  billing_account     = var.billing_account
  skip_delete         = true
  labels              = local.labels
  auto_create_network = false
}

module "project_services" {
  for_each                    = toset(var.projects)
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "~> 13.0"
  activate_apis               = concat(var.default_apis, lookup(var.additional_apis, each.key, []))
  activate_api_identities     = []
  disable_services_on_destroy = true
  disable_dependent_services  = true
  project_id                  = google_project.project[each.key].project_id
}

resource "google_project_default_service_accounts" "default_service_accounts" {
  for_each       = toset(var.projects)
  action         = "DISABLE"
  restore_policy = "REVERT_AND_IGNORE_FAILURE"
  depends_on     = [module.project_services]
  project        = google_project.project[each.key].project_id
}
