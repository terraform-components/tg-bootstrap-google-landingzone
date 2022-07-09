locals {
  namespace       = "tc2"
  name            = "bootstrap"
  tfstate_project = "${local.namespace}-lz-tfstate"

  environment = "lz"

  environments = {
    lz  = "Landingzone"
    dev = "Development"
  }

  stages = [
    "dev",
  ]

  docker_apps = [
    "testapp"
  ]
}
