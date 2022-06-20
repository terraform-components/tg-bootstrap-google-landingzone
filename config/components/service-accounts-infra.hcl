terraform {
  source = "${get_path_to_repo_root()}//stacks/service-accounts-infra"
}

dependency "github-workload-pool" {
  config_path = "${get_path_to_repo_root()}//config/lz/environment/github-workload-pool"
}

locals {
  environment = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.environment
}

dependency "folders" {
  config_path = "${get_path_to_repo_root()}//config/lz/structure/folders"
}

# These inputs get merged with the common inputs from the root
inputs = {
  folder = dependency.folders.outputs.folders[local.environment]

  repositories = [
    "sandrom/tf-gcp-bootstrap"
  ]
  github_workload_identity_pool = dependency.github-workload-pool.outputs.workload_identity_pool
}
