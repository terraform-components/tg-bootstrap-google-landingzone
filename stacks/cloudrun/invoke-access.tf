resource "google_cloud_run_service_iam_binding" "main" {
  location = google_cloud_run_service.main.location
  service  = google_cloud_run_service.main.name
  role     = "roles/run.invoker"
  members  = var.invokers
}
