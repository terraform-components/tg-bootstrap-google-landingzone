include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_path_to_repo_root()}//stacks/kms"
}

inputs = {
  keys = [
    "artifacts",
  ]

  service_identities = {
    artifacts = ["artifactregistry.googleapis.com"]
  }
}
