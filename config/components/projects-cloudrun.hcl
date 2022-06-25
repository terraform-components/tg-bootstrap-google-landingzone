terraform {
  source = "${get_path_to_repo_root()}//stacks/projects"
}

locals {
  environment   = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.environment
  cloudrun_apps = read_terragrunt_config(find_in_parent_folders("context.hcl")).locals.cloudrun_apps
}

dependency "base" {
  config_path = "../projects-base"
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
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "deploymentmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudtasks.googleapis.com",
    "appengine.googleapis.com",
    "iap.googleapis.com",
    "redis.googleapis.com",
    "cloudkms.googleapis.com",
  ]

  projects = local.cloudrun_apps
}
