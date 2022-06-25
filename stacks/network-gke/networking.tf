locals {
  # use https://googlecloudplatform.github.io/gke-ip-address-management/
}

resource "google_compute_subnetwork" "sn" {
  network                  = var.network
  name                     = format(local.name_format[var.region], "${var.name}-gke")
  ip_cidr_range            = var.cidr.nodes
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.cidr.services
  }

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.cidr.pods
  }
}
