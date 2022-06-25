locals {
  context         = "sm"
  tfstate_project = "${local.context}-lz-tfstate"
  owner           = "sandrom"
  environments = {
    lz  = "SM Landingzone"
    dev = "SM Development"
    prd = "SM Production"
  }
  cloudrun_apps = [
    "cloudrun-simple",
    "cloudrun-vpc",
  ]
  docker_apps = concat(local.cloudrun_apps, [
    "gke-testapp",
  ])
}
