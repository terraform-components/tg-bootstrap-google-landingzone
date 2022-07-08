# For planning we need to view stuff in terraform
resource "google_service_account" "infra_reviewer" {
  account_id   = "${var.environment}-reviewer"
  display_name = "${var.environment} Infrastructure Viewer"
  project      = data.google_project.current.project_id
}

# Binding to the Github Repositories to assume this role.
resource "google_service_account_iam_binding" "infra_reviewer_workload_identity_user" {
  service_account_id = google_service_account.infra_reviewer.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    for repo in toset(var.repositories) :
    "principalSet://iam.googleapis.com/${var.github_workload_identity_pool}/attribute.repository_base_ref_workflow/${repo}/${var.main_branch}/${var.review_workflow}"
  ]
}

resource "google_service_account_iam_binding" "infra_reviewer_token_creator" {
  service_account_id = google_service_account.infra_reviewer.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.reviewers
}

resource "google_organization_iam_member" "infra_reviewer" {
  org_id = var.org_id
  role   = "roles/viewer"
  member = "serviceAccount:${google_service_account.infra_reviewer.email}"
}

resource "google_organization_iam_member" "infra_reviewer_folder_viewer" {
  org_id = var.org_id
  role   = "roles/resourcemanager.folderViewer"
  member = "serviceAccount:${google_service_account.infra_reviewer.email}"
}

resource "google_organization_iam_member" "infra_reviewer_security_reviewer" {
  org_id = var.org_id
  role   = "roles/iam.securityReviewer"
  member = "serviceAccount:${google_service_account.infra_reviewer.email}"
}

resource "google_organization_iam_member" "infra_reviewer_billing_viewer" {
  org_id = var.org_id
  role   = "roles/billing.viewer"
  member = "serviceAccount:${google_service_account.infra_reviewer.email}"
}

