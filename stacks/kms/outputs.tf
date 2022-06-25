output "keys" {
  value = {
    for k, v in var.keys : k => google_kms_crypto_key.main[k].id
  }
}
