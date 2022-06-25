output "subnet" {
  value = google_compute_subnetwork.sn.id
}

output "cidr" {
  value = var.cidr
}
