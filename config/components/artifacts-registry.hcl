terraform {
  source = "${get_path_to_repo_root()}//stacks/artifacts-registry"
}

locals {
  apps = read_terragrunt_config(find_in_parent_folders("context.hcl")).locals.apps
}

inputs = {
  docker = concat(local.apps, [])
}
