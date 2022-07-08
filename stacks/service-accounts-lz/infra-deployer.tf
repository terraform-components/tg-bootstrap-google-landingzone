# Deployer Service Account for Terraform
resource "google_service_account" "infra_deployer" {
  account_id   = "${var.environment}-deployer"
  display_name = "${var.environment} Infrastructure Deployer"
  project      = data.google_project.current.project_id
}

# Binding to the Github Repositories to assume this role.
resource "google_service_account_iam_binding" "infra_deployer_workload_identity_user" {
  service_account_id = google_service_account.infra_deployer.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    for repo in toset(var.repositories) :
    "principalSet://iam.googleapis.com/${var.github_workload_identity_pool}/attribute.repository_ref_workflow_environment/${repo}/refs/heads/${var.main_branch}/${var.deploy_workflow}/${var.environment}"
  ]
}

resource "google_service_account_iam_binding" "infra_deployer_token_creator" {
  service_account_id = google_service_account.infra_deployer.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.deployers
}

resource "google_organization_iam_member" "infra_deployer" {
  org_id = var.org_id
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.infra_deployer.email}"
}

resource "google_organization_iam_member" "infra_deployer_folder_admin" {
  org_id = var.org_id
  role   = "roles/resourcemanager.folderAdmin"
  member = "serviceAccount:${google_service_account.infra_deployer.email}"
}

resource "google_organization_iam_member" "infra_deployer_billing_user" {
  org_id = var.org_id
  role   = "roles/billing.user"
  member = "serviceAccount:${google_service_account.infra_deployer.email}"
}
