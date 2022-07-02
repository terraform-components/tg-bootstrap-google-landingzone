include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "projects" {
  path = find_in_parent_folders("components/projects.hcl")
}

# These inputs get merged with the common inputs from the root
inputs = {

  environments = { lz = dependency.folders.outputs.environments["lz"] }

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ]

  projects = [
    "management",
    "artifacts",
  ]

  additional_apis = {
    artifacts = [
      "artifactregistry.googleapis.com",
      "cloudkms.googleapis.com",
    ]
    management = [
      "iamcredentials.googleapis.com",
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
      "container.googleapis.com",
      "sourcerepo.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "serviceusage.googleapis.com",
      "secretmanager.googleapis.com",
    ]
  }
}

