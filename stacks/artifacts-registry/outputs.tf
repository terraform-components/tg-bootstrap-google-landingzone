output "repositories" {
  value = {
    for r in toset(var.docker_apps) :
    r => google_artifact_registry_repository.docker[r].id
  }
}

