locals {
  tfstate_project = "${local.context}-lz-tfstate"
  environments = {
    lz  = "Landingzone"
    dev = "Development"
    prd = "Production"
  }
  stages = [
    "dev",
    "prd"
  ]
  docker_apps = [
    "testapp"
  ]
}
