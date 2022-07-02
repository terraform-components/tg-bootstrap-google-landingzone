output "environments" {
  value = {
    for k, v in google_folder.environments : k => v.name
  }
}

output "stages" {
  value = {
    for k in toset(var.stages) : k => google_folder.environments[k].name
  }
}
