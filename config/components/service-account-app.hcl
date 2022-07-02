terraform {
  source = "${get_path_to_repo_root()}//stacks/service-account-app"
}

# These inputs get merged with the common inputs from the root
inputs = {
}
