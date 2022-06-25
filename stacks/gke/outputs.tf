output "cluster" {
  value = {
    name = google_container_cluster.main.name
  }
}
