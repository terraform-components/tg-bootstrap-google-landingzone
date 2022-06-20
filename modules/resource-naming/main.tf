locals {
  name_format_global   = "${var.context}-${var.environment}-%s"
  name_format_regional = "${local.name_format_global}-%s"
  name_format_zonal    = "${local.name_format_regional}%s"

  name_format = merge(
    { for k, v in local.regions : k => "${local.name_format_global}-${v}" },
    { for k, v in local.multi_regions : k => "${local.name_format_global}-${v}" },
    { "global" = local.name_format_global },
    {
      for k in setproduct(keys(local.regions), toset(["a", "b", "c", "d", "e", "f", "g"])) :
      "${k[0]}-${k[1]}" => "${local.name_format_global}-${local.regions[k[0]]}${k[1]}"
    }
  )

  regions = {
    "asia-east1"           = "ae1"
    "asia-east2"           = "ae2"
    "asia-northeast1"      = "ane1"
    "asia-northeast2"      = "ane2"
    "asia-northeast3"      = "ane3"
    "asia-south1"          = "as1"
    "asia-south2"          = "as2"
    "asia-southeast1"      = "ase1"
    "asia-southeast2"      = "ase2"
    "australia-southeast1" = "ause1"
    "australia-southeast2" = "ause2"

    "europe-west1"    = "euw1"
    "europe-west2"    = "euw2" // london
    "europe-west3"    = "euw3"
    "europe-west4"    = "euw4"
    "europe-west6"    = "euw6"
    "europe-central2" = "euc2"
    "europe-north1"   = "eun1"

    "northamerica-northeast1" = "nane1"
    "northamerica-northeast2" = "nane2"

    "us-central1" = "usc1"
    "us-central2" = "usc2" // do not use
    "us-east1"    = "use1"
    "us-east4"    = "use4"
    "us-west1"    = "usw1"
    "us-west2"    = "usw2"
    "us-west3"    = "usw3"
    "us-west4"    = "usw4"

    "southamerica-east1" = "sae1"
    "southamerica-west1" = "saw1"
  }

  multi_regions = {
    // multi
    "asia" = "asia"
    "us"   = "us"
    "eu"   = "eu"

    // dual
    "eur4"   = "eur4"   // EUROPE-NORTH1 and EUROPE-WEST4.
    "asia1"  = "a1"     // ASIA-NORTHEAST1 and ASIA-NORTHEAST2.
    "nam4"   = "nam4"   // US-CENTRAL1 and US-EAST1.
    "europe" = "europe" // special used in some places like https://cloud.google.com/kms/docs/locations for european union
  }
}
