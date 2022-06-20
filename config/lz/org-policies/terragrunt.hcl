include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "org-policies" {
  path = find_in_parent_folders("components/org-policies.hcl")
}

inputs = {
}
