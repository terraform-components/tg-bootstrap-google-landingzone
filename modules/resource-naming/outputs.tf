output "format" {
  value = local.name_format
}

# # https://cloud.google.com/storage/docs/locations
output "lookup" {
  value = merge(local.regions, local.multi_regions)
}
