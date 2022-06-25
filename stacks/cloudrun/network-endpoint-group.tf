resource "google_compute_region_network_endpoint_group" "main" {
  provider              = google-beta
  name                  = format(local.name_format[var.region], var.name)
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = google_cloud_run_service.main.name
  }
}
