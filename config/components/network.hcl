terraform {
  source = "${get_path_to_repo_root()}//stacks/network"
}

# These inputs get merged with the common inputs from the root
inputs = {
  cidr_service_networking = "10.129.0.0/16"
}
