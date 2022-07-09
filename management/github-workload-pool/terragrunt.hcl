include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_path_to_repo_root()}//stacks/github-workload-pool"
}

dependency "projects" {
  config_path = "../projects/lz"
}

inputs = {
}
