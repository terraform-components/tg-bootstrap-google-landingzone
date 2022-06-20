output "workload_identity_pool" {
  value = google_iam_workload_identity_pool.github.name
}

output "workload_identity_pool_provider" {
  value = google_iam_workload_identity_pool_provider.github.name
}
