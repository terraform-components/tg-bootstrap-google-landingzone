resource "google_kms_key_ring" "main" {
  name     = format(local.name_format[var.region], "${var.name}")
  location = var.region
}

resource "google_kms_crypto_key" "main" {
  for_each        = var.keys
  name            = format(local.name_format[var.region], "${var.name}-${each.key}")
  key_ring        = google_kms_key_ring.main.id
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

resource "google_kms_crypto_key_iam_member" "gke" {
  for_each      = { for k, v in var.keys : k => v if v.gke == true }
  crypto_key_id = google_kms_crypto_key.main[each.key].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current.number}@container-engine-robot.iam.gserviceaccount.com"
}
