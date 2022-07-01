include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "common" {
  path = find_in_parent_folders("components/projects-env.hcl")
}

inputs = {
  folder      = dependency.folders.outputs.folders["dev"]
  environment = "dev"
}
