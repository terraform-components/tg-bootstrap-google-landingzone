output "repositories" {
  value = {
    for r in toset(var.docker) :
    r => google_artifact_registry_repository.docker[r].id
  }
}

