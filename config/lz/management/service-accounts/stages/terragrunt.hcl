include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "common" {
  path = find_in_parent_folders("components/service-accounts.hcl")
}

terraform {
  source = "${get_path_to_repo_root()}//stacks/service-accounts-stages"
}

inputs = {
  stages = dependency.folders.outputs.stages
}
