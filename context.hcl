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

  # budgets

  # default budget per project unless otherwise specified
  # structure supplied to be able to override settings only partly
  default_project_budget = {
    currency_code = "EUR"
    amount        = "10"

    # both current
    threshold_rules = [
      {
        threshold_percent = 1.0
        spend_basis       = "CURRENT_SPEND"
      },
      # and forecasted
      {
        threshold_percent = 1.0
        spend_basis       = "FORECASTED_SPEND"
      }
    ]

  }
}
