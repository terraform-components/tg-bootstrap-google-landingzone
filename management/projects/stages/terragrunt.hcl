include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "projects" {
  path = find_in_parent_folders("components/projects.hcl")
}

# These inputs get merged with the common inputs from the root
inputs = {
  environments = dependency.folders.outputs.stages

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "billingbudgets.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "deploymentmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudtasks.googleapis.com",
    "appengine.googleapis.com",
    "iap.googleapis.com",
    "redis.googleapis.com",
    "cloudkms.googleapis.com",
  ]

  projects = [
    "cloudrun-simple",
  ]

  additional_apis = {
  }
}

