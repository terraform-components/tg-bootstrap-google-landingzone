terraform {
  source = "${get_path_to_repo_root()}//stacks/network-gke"
}

dependency "network" {
  config_path = "../../network"
}

# These inputs get merged with the common inputs from the root
inputs = {
  network = dependency.network.outputs.network
}
