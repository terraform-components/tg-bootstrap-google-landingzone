locals {
  context         = "sm"
  tfstate_project = "${local.context}-lz-tfstate"
  owner           = "sandrom"
  environments = {
    lz  = "SM Landingzone"
    dev = "SM Development"
    prd = "SM Production"
  }
  apps = [
    "app1"
  ]
}
