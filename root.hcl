locals {
  context_vars = read_terragrunt_config(find_in_parent_folders("context.hcl"))

  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))

  region  = local.location_vars.locals.region
  project = local.project_vars.locals.project
}

# Generate a GCP provider block
generate "provider" {
  path      = "main.provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google-beta" {
  project = local.project
  region = local.region
}

provider "google" {
  project = local.project
  region = local.region
}
EOF
}



generate "locals" {
  path      = "main.locals.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
locals {
  name_format   = module.resource_naming.format

  region        = "${local.region}"
  project       = "${local.project}"
  name_global   = format(local.name_format["global"], var.name)
  name_regional = format(local.name_format[local.region], var.name)
  labels = {}
}

module "resource_naming" {
  source      = "github.com/terraform-components/terraform-google-naming"
}

variable "name" {
  type = string
}

EOF
}

remote_state {
  backend = "gcs"
  config = {
    project                   = local.project
    location                  = local.region
    bucket                    = "${local.project}-tfstate"
    prefix                    = "${path_relative_to_include()}"
    enable_bucket_policy_only = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.context_vars.locals,
  local.project_vars.locals,
  local.location_vars.locals,
)
