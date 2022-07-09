module "keys" {
  source             = "github.com/terraform-components/terraform-google-kms-keys"
  name_format        = local.name_format["global"]
  name               = var.name
  location           = var.location
  labels             = local.labels
  keys               = var.keys
  service_identities = var.service_identities
}
