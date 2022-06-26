# reserving a global ip may even be better in its own stack as you often want to keep this most consistent.
resource "google_compute_global_address" "main" {
  name = format(local.name_format["global"], var.name)
}
