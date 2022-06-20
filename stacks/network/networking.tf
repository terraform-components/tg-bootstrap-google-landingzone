
locals {
}

resource "google_compute_network" "vpc" {
  name                    = format(local.name_format["global"], "vpc")
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "private_ip" {
  name          = format(local.name_format["global"], "private-ip")
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = split("/", var.cidr_service_networking)[0]
  prefix_length = split("/", var.cidr_service_networking)[1]
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_ip_vpc_connection" {
  network = google_compute_network.vpc.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip.name
  ]
}
