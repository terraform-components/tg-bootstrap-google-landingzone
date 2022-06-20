output "network" {
  value = google_compute_network.vpc.id
}

output "cidr_service_networking" {
  value = var.cidr_service_networking
}
