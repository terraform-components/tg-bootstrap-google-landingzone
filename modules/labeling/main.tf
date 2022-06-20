locals {
  owner       = { "owner" = var.owner }
  environment = { "environment" = var.environment }

  labels = merge(
    local.owner,
    local.environment
  )

}


