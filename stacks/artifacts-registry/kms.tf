resource "google_kms_key_ring" "artifacts" {
  name     = format(local.name_format[var.region], "artifacts")
  location = var.region
}

resource "google_kms_crypto_key" "artifacts" {
  name            = format(local.name_format[var.region], "artifacts")
  key_ring        = google_kms_key_ring.artifacts.id
  rotation_period = "7776000s" # 90 days
  purpose         = "ENCRYPT_DECRYPT"

  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }

  lifecycle {
    prevent_destroy = true
  }
}

data "google_project" "current" {
  project_id = var.project
}

resource "google_kms_crypto_key_iam_binding" "artifacts" {
  crypto_key_id = google_kms_crypto_key.artifacts.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:service-${data.google_project.current.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com",
  ]
}
