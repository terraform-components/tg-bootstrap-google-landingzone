# https://github.com/google-github-actions/auth#setup

resource "google_iam_workload_identity_pool" "github" {
  provider                  = google-beta
  workload_identity_pool_id = "github"
  display_name              = "github"
  description               = "Github"
}

# https://cloud.google.com/iam/docs/configuring-workload-identity-federation
resource "google_iam_workload_identity_pool_provider" "github" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  # https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#understanding-the-oidc-token
  attribute_mapping = {
    "google.subject"                                 = "assertion.sub"
    "attribute.actor"                                = "assertion.actor"
    "attribute.aud"                                  = "assertion.aud"
    "attribute.repository"                           = "assertion.repository"
    "attribute.repository_owner"                     = "assertion.repository_owner"
    "attribute.event_name"                           = "assertion.event_name"
    "attribute.environment"                          = "assertion.environment"
    "attribute.ref"                                  = "assertion.ref"
    "attribute.workflow"                             = "assertion.workflow"
    "attribute.job_workflow_ref"                     = "assertion.job_workflow_ref" # e.g. "octo-org/octo-automation/.github/workflows/oidc.yml@refs/heads/main",
    "attribute.repository_ref"                       = "assertion.repository + '/' + assertion.ref"
    "attribute.repository_ref_workflow"              = "assertion.repository + '/' + assertion.ref + '/' + assertion.workflow"
    "attribute.repository_ref_workflow_environment"  = "assertion.repository + '/' + assertion.ref + '/' + assertion.workflow + '/' + assertion.environment"
    "attribute.repository_base_ref_job_workflow_ref" = "assertion.repository + '/' + assertion.base_ref + '/' + assertion.job_workflow_ref"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
