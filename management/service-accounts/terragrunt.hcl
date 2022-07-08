include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "github-workload-pool" {
  config_path = "../github-workload-pool"
}

dependency "folders" {
  config_path = "../folders"
}

terraform {
  source = "${get_path_to_repo_root()}//stacks/service-accounts-lz"
}

# These inputs get merged with the common inputs from the root
inputs = {
  repositories = [
    "sandromanke/tf-gcp-bootstrap"
  ]
  github_workload_identity_pool = dependency.github-workload-pool.outputs.workload_identity_pool
}
