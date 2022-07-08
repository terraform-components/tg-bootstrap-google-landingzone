
module "cmk" {
  source             = "github.com/terraform-components/tf-module-google-kms-cmk"
  name               = format(local.name_format[var.location], var.name)
  location           = var.location
  labels             = local.labels
  service_identities = ["artifactregistry.googleapis.com"]
}

resource "google_artifact_registry_repository" "docker" {
  for_each = toset(var.docker_apps)
  provider = google-beta

  location      = var.location
  repository_id = "docker-${each.value}"
  format        = "DOCKER"
  kms_key_name  = module.cmk.kms_key_id
}
