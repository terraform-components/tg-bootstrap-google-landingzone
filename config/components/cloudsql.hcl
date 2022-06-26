terraform {
  source = "${get_path_to_repo_root()}//stacks/cloudsql"
}

# These inputs get merged with the common inputs from the root
inputs = {
}
