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
  ]

  additional_apis = {
    # "monitoring" = [
    #   "logging.googleapis.com",
    # ]
  }
}
