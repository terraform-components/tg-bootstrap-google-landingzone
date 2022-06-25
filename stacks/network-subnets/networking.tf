locals {
  subnets = {
    for subnet, subnetnum in var.subnets :
    subnet => {
      range     = cidrsubnet(var.cidr_subnets, var.subnet_bits, subnetnum)
      secondary = {}
      location  = var.region
    }
  }

}

resource "google_compute_subnetwork" "sn" {
  for_each                 = local.subnets
  network                  = var.network
  name                     = format(local.name_format[each.value.location], "${var.name}-${each.key}")
  ip_cidr_range            = each.value.range
  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }

  }
}
