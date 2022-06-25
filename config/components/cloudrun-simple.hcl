terraform {
  source = "${get_path_to_repo_root()}//stacks/cloudrun"
}

dependency "service-account" {
  config_path = "../../service-account"
}


# These inputs get merged with the common inputs from the root
inputs = {
  service_account = dependency.service-account.outputs.email
}
