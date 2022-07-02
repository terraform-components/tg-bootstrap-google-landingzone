locals {
  projects = { for _, v in setproduct(keys(var.environments), var.projects) :
    "${v[0]}-${v[1]}" => {
      project     = v[1]
      environment = v[0]
      folder      = var.environments[v[0]]
    }
  }
}

resource "google_project" "project" {
  for_each            = local.projects
  name                = "${var.context}-${each.value.environment}-${each.value.project}"
  project_id          = "${var.context}-${each.value.environment}-${each.value.project}"
  folder_id           = each.value.folder
  billing_account     = var.billing_account
  skip_delete         = true
  labels              = local.labels
  auto_create_network = false
}

module "project_services" {
  for_each                    = local.projects
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "~> 13.0"
  activate_apis               = concat(var.default_apis, lookup(var.additional_apis, each.value.project, []))
  activate_api_identities     = []
  disable_services_on_destroy = true
  disable_dependent_services  = true
  project_id                  = google_project.project[each.key].project_id
}

resource "google_project_default_service_accounts" "default_service_accounts" {
  for_each       = local.projects
  action         = "DISABLE"
  restore_policy = "REVERT_AND_IGNORE_FAILURE"
  depends_on     = [module.project_services]
  project        = google_project.project[each.key].project_id
}
