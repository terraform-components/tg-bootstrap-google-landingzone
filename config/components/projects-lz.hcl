terraform {
  source = "${get_path_to_repo_root()}//stacks/projects"
}

dependency "structure-folders" {
  config_path = "../../structure/folders"
}

# These inputs get merged with the common inputs from the root
inputs = {

  folder = dependency.structure-folders.outputs.folders["lz"]

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ]

  projects = [
    "monitoring",
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
    ]
  }
}
