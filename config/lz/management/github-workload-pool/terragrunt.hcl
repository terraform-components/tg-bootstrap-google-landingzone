include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "github-workload-pool" {
  path = find_in_parent_folders("components/github-workload-pool.hcl")
}

inputs = {
}
