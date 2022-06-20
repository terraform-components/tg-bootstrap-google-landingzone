module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 13.0"

  activate_apis = [
    "logging.googleapis.com",
    "cloudkms.googleapis.com",
  ]
  activate_api_identities     = []
  disable_services_on_destroy = true
  disable_dependent_services  = true
  project_id                  = google_project.self.project_id
}
