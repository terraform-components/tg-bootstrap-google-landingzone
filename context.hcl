locals {
  context         = "tc"
  name            = "bootstrap"
  tfstate_project = "${local.context}-lz-tfstate"

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
