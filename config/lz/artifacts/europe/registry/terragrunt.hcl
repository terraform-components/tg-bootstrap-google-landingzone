include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "tfstate" {
  path = find_in_parent_folders("components/artifacts-registry.hcl")
}

inputs = {
}
