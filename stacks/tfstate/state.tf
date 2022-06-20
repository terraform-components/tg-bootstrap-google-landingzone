resource "random_string" "tfstate" {
  length  = 6
  lower   = true
  upper   = false
  special = false
}

resource "google_storage_bucket" "tfstate" {
  for_each                    = var.environments
  name                        = format(local.name_format["global"], "tfstate-${each.key}-${random_string.tfstate.result}")
  location                    = "EU"
  storage_class               = "MULTI_REGIONAL"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.main.id
  }

  labels = local.labels
}

output "buckets" {
  value = {
    for b in google_storage_bucket.tfstate :
    b.name => b.self_link
  }
}
