# Deployer Service Account for Terraform
resource "google_service_account" "infra_deployer" {
  account_id   = "${var.environment}-deployer"
  display_name = "${var.environment} Infrastructure Deployer"
  project      = var.project
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

resource "google_folder_iam_member" "infra_deployer" {
  folder = var.folder
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.infra_deployer.email}"
}

resource "google_folder_iam_member" "infra_deployer_folder_viewer" {
  folder = var.folder
  role   = "roles/resourcemanager.folderViewer"
  member = "serviceAccount:${google_service_account.infra_deployer.email}"
}

resource "google_project_iam_member" "infra_deployer_tfstate" {
  project = var.tfstate_project
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.infra_deployer.email}"
}

resource "google_project_iam_member" "infra_deployer_tfstate_viewer" {
  project = "${var.context}-lz-tfstate"
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.infra_deployer.email}"
}
