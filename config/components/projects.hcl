terraform {
  source = "${get_path_to_repo_root()}//stacks/projects"
}

dependency "folders" {
  config_path = "../../folders"
}
