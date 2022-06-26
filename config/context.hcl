locals {
  context         = "sm"
  tfstate_project = "${local.context}-lz-tfstate"
  owner           = "sandrom"
  billing_account = "TBD"
  org_id          = "TBD"
  environments = {
    lz  = "SM Landingzone"
    dev = "SM Development"
    prd = "SM Production"
  }
  docker_apps = [
    "testapp"
  ]
}
