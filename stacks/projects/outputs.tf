output "projects" {
  value = merge(
    {
      for k, v in google_project.project : k => v.project_id
    }
  )
}
