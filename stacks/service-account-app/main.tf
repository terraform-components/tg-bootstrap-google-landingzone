# usually applications are global, but you can have different use cases too.

resource "google_service_account" "main" {
  account_id   = var.name
  display_name = format(local.name_format["global"], "${var.name}")
}

resource "google_project_iam_custom_role" "main" {
  count       = length(var.application_permissions) > 0 ? 1 : 0
  role_id     = replace(var.name, "-", "_")
  title       = "${var.name} Application Permissions"
  description = "The additional permissions we give to the application ${var.name}"
  permissions = var.application_permissions
}

resource "google_project_iam_member" "main" {
  count   = length(var.application_permissions) > 0 ? 1 : 0
  project = var.project
  role    = join("", google_project_iam_custom_role.main.*.name)
  member  = "serviceAccount:${google_service_account.main.email}"
}
