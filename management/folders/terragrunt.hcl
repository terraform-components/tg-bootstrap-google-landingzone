include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "folders" {
  path = find_in_parent_folders("components/folders.hcl")
}

inputs = {
}
