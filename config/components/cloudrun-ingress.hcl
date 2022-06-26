terraform {
  source = "${get_path_to_repo_root()}//stacks/loadbalancer-l7-global"
}

dependency "cloudrun" {
  config_path = "../europe-west3/cloudrun"
}

# These inputs get merged with the common inputs from the root
inputs = {
  backend_network_endpoint_group_id = dependency.cloudrun.outputs.network_endpoint_group_id
  domains = {
    foo = ["cloudrun.sandrom.de"]
  }
}
