terraform {
  source = "${get_path_to_repo_root()}//stacks/network-subnets"
}

dependency "network" {
  config_path = "../../network"
}

# These inputs get merged with the common inputs from the root
inputs = {
  network      = dependency.network.outputs.network
  cidr_subnets = "10.128.0.0/20"

  subnets = {
    public      = 0
    mgmt        = 1
    internal-lb = 2
  }
}
