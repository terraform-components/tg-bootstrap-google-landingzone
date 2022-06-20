terraform {
  source = "${get_path_to_repo_root()}//stacks/projects"
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

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ]

  projects = [
    "monitoring",
  ]

  additional_apis = {
  }
}
