resource "google_compute_backend_service" "main" {
  name                            = format(local.name_format["global"], var.name)
  protocol                        = "HTTPS"
  timeout_sec                     = 30
  connection_draining_timeout_sec = 30
  enable_cdn                      = var.cdn
  #security_policy                 = google_compute_security_policy.main.id
  backend {
    group = var.backend_network_endpoint_group_id
  }
}

resource "google_compute_url_map" "main" {
  name            = format(local.name_format["global"], var.name)
  default_service = google_compute_backend_service.main.id # default backend likely different

  host_rule {
    hosts        = distinct(flatten([for _, v in var.domains : v]))
    path_matcher = "paths"
  }

  path_matcher {
    name            = "paths"
    default_service = google_compute_backend_service.main.id

    # actual matching
  }
}

#configure an HTTPS proxy to terminate the traffic with the Google-managed certificate and route it to the URL map
resource "google_compute_target_https_proxy" "main" {
  name             = format(local.name_format["global"], var.name)
  url_map          = google_compute_url_map.main.id
  ssl_certificates = [for _, certificate in google_compute_managed_ssl_certificate.main : certificate.id]
  ssl_policy       = google_compute_ssl_policy.main.name
}

resource "google_compute_ssl_policy" "main" {
  name            = format(local.name_format["global"], var.name)
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_global_forwarding_rule" "main" {
  name       = format(local.name_format["global"], var.name)
  target     = google_compute_target_https_proxy.main.id
  port_range = "443"
  ip_address = google_compute_global_address.main.address
}
