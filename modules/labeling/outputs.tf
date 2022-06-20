output "labels" {
  value = local.labels
}

output "label_map" {
  value = {
    owner       = local.owner
    environment = local.environment
  }
}
