terraform {
  source = "${get_path_to_repo_root()}//stacks/projects"
}

dependency "folders" {
  config_path = "${get_path_to_repo_root()}//config/lz/structure/folders"
}

# These inputs get merged with the common inputs from the root
inputs = {

  default_apis = [
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ]

  projects = [
    "monitoring",
    "cloudrun-simple",
  ]

  additional_apis = {
    cloudrun-simple = [
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
