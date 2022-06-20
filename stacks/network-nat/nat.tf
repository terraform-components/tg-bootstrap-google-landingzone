resource "google_compute_router" "main" {
  name    = format(local.name_format["global"], "main")
  network = var.network
}

resource "google_compute_router_nat" "main" {
  name                               = format(local.name_format["global"], "main")
  router                             = google_compute_router.main.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
