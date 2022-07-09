include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "projects" {
  path = find_in_parent_folders("components/projects.hcl")
}

# These inputs get merged with the common inputs from the root
inputs = {

  environments = dependency.folders.outputs.environments

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "billingbudgets.googleapis.com",
  ]

  projects = [
    "monitoring",
  ]

  additional_apis = {
  }
}

