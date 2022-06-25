terraform {
  source = "${get_path_to_repo_root()}//stacks/gke"
}

dependency "network" {
  config_path = "../../network"
}

dependency "network-gke" {
  config_path = "../network-gke"
}

dependency "kms" {
  config_path = "../kms"
}

# These inputs get merged with the common inputs from the root
inputs = {
  network                = dependency.network.outputs.network
  subnet                 = dependency.network-gke.outputs.subnet
  cidr_master            = dependency.network-gke.outputs.cidr.master
  kms_key_id             = dependency.kms.outputs.keys.gke
  gke_min_master_version = "1.22"
}
