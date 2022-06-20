output "folders" {
  value = {
    for k, v in google_folder.environments : k => v.name
  }
}
