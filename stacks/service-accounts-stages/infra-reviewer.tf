# For planning we need to view stuff in terraform
resource "google_service_account" "infra_reviewer" {
  for_each     = var.stages
  account_id   = "${each.key}-reviewer"
  display_name = "${each.key} Infrastructure Viewer"
  project      = var.project
}

# Binding to the Github Repositories to assume this role.
resource "google_service_account_iam_binding" "infra_reviewer_workload_identity_user" {
  for_each           = var.stages
  service_account_id = google_service_account.infra_reviewer[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    for repo in toset(var.repositories) :
    "principalSet://iam.googleapis.com/${var.github_workload_identity_pool}/attribute.repository_base_ref_workflow/${repo}/${var.main_branch}/${var.review_workflow}"
  ]
}

resource "google_service_account_iam_binding" "infra_reviewer_token_creator" {
  for_each           = var.stages
  service_account_id = google_service_account.infra_reviewer[each.key].name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.reviewers
}

##
# permissions
resource "google_folder_iam_member" "infra_reviewer_viewer" {
  for_each = var.stages
  folder   = each.value
  role     = "roles/viewer"
  member   = "serviceAccount:${google_service_account.infra_reviewer[each.key].email}"
}

resource "google_folder_iam_member" "infra_reviewer_folder_viewer" {
  for_each = var.stages
  folder   = each.value
  role     = "roles/resourcemanager.folderViewer"
  member   = "serviceAccount:${google_service_account.infra_reviewer[each.key].email}"
}

resource "google_folder_iam_member" "infra_reviewer_security_reviewer" {
  for_each = var.stages
  folder   = each.value
  role     = "roles/iam.securityReviewer"
  member   = "serviceAccount:${google_service_account.infra_reviewer[each.key].email}"
}

resource "google_project_iam_member" "infra_reviewer_tfstate" {
  for_each = var.stages
  project  = var.tfstate_project
  role     = "roles/storage.objectViewer"
  member   = "serviceAccount:${google_service_account.infra_reviewer[each.key].email}"
}

resource "google_project_iam_member" "infra_reviewer_tfstate_viewer" {
  for_each = var.stages
  project  = "${var.context}-lz-tfstate"
  role     = "roles/viewer"
  member   = "serviceAccount:${google_service_account.infra_reviewer[each.key].email}"
}
