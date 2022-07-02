locals {
  context         = "sm"
  tfstate_project = "${local.context}-lz-tfstate"
  owner           = "sandrom"
  environments = {
    lz  = "SM Landingzone"
    dev = "SM Development"
    prd = "SM Production"
  }
  stages = [
    "dev",
    "prd"
  ]
  docker_apps = [
    "testapp"
  ]
}
