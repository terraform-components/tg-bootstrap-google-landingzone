resource "google_compute_firewall" "ssh" {
  name        = format(local.name_format["global"], "iap-to-instances")
  network     = google_compute_network.vpc.self_link
  description = "Allow access for ssh from e.g. IAP or static ip address ranges"
  direction   = "INGRESS"
  source_ranges = [
    "35.235.240.0/20", # iap
  ]
  # anywhere for now

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
