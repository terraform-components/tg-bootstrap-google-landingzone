locals {
  context = read_terragrunt_config(find_in_parent_folders("context.hcl")).locals.context
  project = "${local.context}-lz-artifacts"
}
