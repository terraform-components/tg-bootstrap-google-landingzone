locals {
  namespace = read_terragrunt_config(find_in_parent_folders("context.hcl")).locals.namespace
  project   = "${local.namespace}-lz-management"
}
