terraform {
  source = "${get_path_to_repo_root()}//stacks/service-accounts-infra"
}

dependency "github-workload-pool" {
  config_path = "${get_path_to_repo_root()}//config/lz/environment/github-workload-pool"
}

dependency "folders" {
  config_path = "../folders"
}

# These inputs get merged with the common inputs from the root
inputs = {
  repositories = [
    "sandrom/tf-gcp-bootstrap"
  ]
  github_workload_identity_pool = dependency.github-workload-pool.outputs.workload_identity_pool
}
