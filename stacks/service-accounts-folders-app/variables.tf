variable "name" {
  type = string
}

variable "application_permissions" {
  type = list(string)
  default = [
    "storage.objects.list",
    "storage.objects.get",
  ]
}

