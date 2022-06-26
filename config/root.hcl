locals {
  # Automatically load context-level variables
  context_vars = read_terragrunt_config(find_in_parent_folders("context.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load location-level variables
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))

  # Automatically load account-level variables
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  # Extract the variables we need for easy access
  region      = local.location_vars.locals.region
  environment = local.environment_vars.locals.environment
  context     = local.context_vars.locals.context
}

# Generate a GCP provider block
generate "provider" {
  path      = "main.provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google-beta" {
  project = var.project
  region = var.region
}

provider "google" {
  project = var.project
  region = var.region
}
EOF
}

generate "commonvars" {
  path      = "main.commonvars.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "labels" {
  type        = map(any)
  default     = {}
  description = "additional labels"
}

variable "context" {
  type        = string
  description = "the context for naming and labeling"
}

variable "environment" {
  type        = string
  description = "environment this is used within"
}

variable "owner" {
  type        = string
  description = "Owner is the Identifying contact information for support team/person."
}

variable "project" {
  description = "project id"
  type        = string
}

variable "region" {
  type        = string
}

EOF
}

generate "locals" {
  path      = "main.locals.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
locals {
  name_format   = module.resource_naming.format

  labels = merge(
    var.labels,
    module.labeling.labels
  )
}

module "resource_naming" {
  source      = "../../modules/resource-naming"
  environment = var.environment
  context     = var.context
}

module "labeling" {
  source      = "../../modules/labeling"
  environment = var.environment
  owner       = var.owner
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in a bucket
remote_state {
  backend = "gcs"
  config = {
    bucket               = "${local.context}-lz-tfstate-${local.environment}-se4xak"
    prefix               = "${path_relative_to_include()}.tfstate"
    skip_bucket_creation = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.context_vars.locals,
  local.environment_vars.locals,
  local.location_vars.locals,
  local.project_vars.locals,
)
