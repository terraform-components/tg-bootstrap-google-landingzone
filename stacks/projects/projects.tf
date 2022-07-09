locals {
  projects = { for _, v in setproduct(keys(var.environments), var.projects) :
    "${v[0]}-${v[1]}" => {
      project     = v[1]
      environment = v[0]
      folder      = var.environments[v[0]]
      budget = merge(
        var.default_project_budget,
        {
          amount = lookup(var.project_budget_amount, v[1], null)
        }
      )
    }
  }
}

resource "google_project" "project" {
  for_each            = local.projects
  name                = "${var.namespace}-${each.value.environment}-${each.value.project}"
  project_id          = "${var.namespace}-${each.value.environment}-${each.value.project}"
  folder_id           = each.value.folder
  billing_account     = var.billing_account
  skip_delete         = true
  labels              = local.labels
  auto_create_network = false
}

resource "google_billing_budget" "project" {
  for_each        = { for k, v in local.projects : k => v if v.budget != null }
  display_name    = "Project Budget ${google_project.project[each.key].name}"
  billing_account = var.billing_account

  budget_filter {
    projects = ["projects/${google_project.project[each.key].number}"]
  }

  amount {
    specified_amount {
      units         = each.value.budget.amount
      currency_code = each.value.budget.currency_code
    }
  }

  dynamic "threshold_rules" {
    for_each = each.value.budget.threshold_rules
    content {
      threshold_percent = threshold_rules.value.threshold_percent
      spend_basis       = threshold_rules.value.spend_basis
    }
  }

  depends_on = [
    module.project_services
  ]
}

module "project_services" {
  for_each                    = local.projects
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "~> 13.0"
  activate_apis               = concat(var.default_apis, lookup(var.additional_apis, each.value.project, []))
  activate_api_identities     = []
  disable_services_on_destroy = true
  disable_dependent_services  = true
  project_id                  = google_project.project[each.key].project_id
}

resource "google_project_default_service_accounts" "default_service_accounts" {
  for_each       = local.projects
  action         = "DISABLE"
  restore_policy = "REVERT_AND_IGNORE_FAILURE"
  depends_on     = [module.project_services]
  project        = google_project.project[each.key].project_id
}
