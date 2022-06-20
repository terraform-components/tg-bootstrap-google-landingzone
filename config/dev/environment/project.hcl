locals {
  context     = read_terragrunt_config(find_in_parent_folders("context.hcl")).locals.context
  environment = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.environment
  project     = "${local.context}-lz-management"
}
