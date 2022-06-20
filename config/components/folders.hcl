terraform {
  source = "${get_path_to_repo_root()}//stacks/folders"
}

dependency "bootstrap-tfstate" {
  config_path = "../../bootstrap/tfstate"
}

inputs = {
}
