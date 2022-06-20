terraform {
  source = "${get_path_to_repo_root()}//stacks/github-workload-pool"
}

dependency "projects" {
  config_path = "../projects"
}

inputs = {
}
