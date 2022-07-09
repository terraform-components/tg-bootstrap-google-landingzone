include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_path_to_repo_root()}//stacks/artifacts-registry"
}

dependency "kms" {
  config_path = "../kms"
}

inputs = {
  kms_key_id = dependency.kms.outputs.kms_key_ids["artifacts"]

}
