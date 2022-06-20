variable "tfstate_project" {
  type = string
}

variable "main_branch" {
  type    = string
  default = "main"
}

variable "deploy_workflow" {
  type    = string
  default = "deploy"
}

variable "review_workflow" {
  type    = string
  default = "review"
}

variable "repositories" {
  type = list(string)
}

variable "github_workload_identity_pool" {
  type = string
}

variable "reviewers" {
  type    = list(string)
  default = []
}

variable "deployers" {
  type    = list(string)
  default = []
}

variable "folder" {
  type = string
}
