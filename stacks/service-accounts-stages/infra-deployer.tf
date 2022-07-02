# Deployer Service Account for Terraform
resource "google_service_account" "infra_deployer" {
  for_each     = var.stages
  account_id   = "${each.key}-deployer"
  display_name = "${each.key} Infrastructure Deployer"
  project      = var.project
}

# Binding to the Github Repositories to assume this role.
resource "google_service_account_iam_binding" "infra_deployer_workload_identity_user" {
  for_each           = var.stages
  service_account_id = google_service_account.infra_deployer[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    for repo in toset(var.repositories) :
    "principalSet://iam.googleapis.com/${var.github_workload_identity_pool}/attribute.repository_ref_workflow_environment/${repo}/refs/heads/${var.main_branch}/${var.deploy_workflow}/${each.key}"
  ]
}

resource "google_service_account_iam_binding" "infra_deployer_token_creator" {
  for_each           = var.stages
  service_account_id = google_service_account.infra_deployer[each.key].name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.deployers
}

resource "google_folder_iam_member" "infra_deployer" {
  for_each = var.stages
  folder   = each.value
  role     = "roles/owner"
  member   = "serviceAccount:${google_service_account.infra_deployer[each.key].email}"
}

resource "google_folder_iam_member" "infra_deployer_folder_viewer" {
  for_each = var.stages
  folder   = each.value
  role     = "roles/resourcemanager.folderViewer"
  member   = "serviceAccount:${google_service_account.infra_deployer[each.key].email}"
}

resource "google_project_iam_member" "infra_deployer_tfstate" {
  for_each = var.stages
  project  = var.tfstate_project
  role     = "roles/storage.objectAdmin"
  member   = "serviceAccount:${google_service_account.infra_deployer[each.key].email}"
}

resource "google_project_iam_member" "infra_deployer_tfstate_viewer" {
  for_each = var.stages
  project  = "${var.context}-lz-tfstate"
  role     = "roles/viewer"
  member   = "serviceAccount:${google_service_account.infra_deployer[each.key].email}"
}
