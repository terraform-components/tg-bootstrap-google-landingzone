resource "google_artifact_registry_repository" "docker" {
  for_each = toset(var.docker_apps)
  provider = google-beta

  location      = var.location
  repository_id = "docker-${each.value}"
  format        = "DOCKER"
}
