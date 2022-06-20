locals {
  kms_location = "europe"
}

resource "google_kms_key_ring" "main" {
  name     = format(local.name_format[local.kms_location], "main")
  location = local.kms_location

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "main" {
  name            = format(local.name_format[local.kms_location], "logs")
  key_ring        = google_kms_key_ring.main.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s" # 90 days

  version_template {
    protection_level = "SOFTWARE"
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }

  lifecycle {
    prevent_destroy = true
  }

  labels = local.labels
}

resource "google_kms_crypto_key_iam_binding" "main" {
  crypto_key_id = google_kms_crypto_key.main.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:service-${google_project.self.number}@gs-project-accounts.iam.gserviceaccount.com",
  ]
}
