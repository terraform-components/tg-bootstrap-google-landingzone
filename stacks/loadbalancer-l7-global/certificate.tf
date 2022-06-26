resource "google_compute_managed_ssl_certificate" "main" {
  for_each = var.domains
  provider = google-beta

  name = replace(each.key, ".", "-")

  managed {
    domains = each.value
  }

  lifecycle {
    create_before_destroy = true
  }
}
