variable "name" {
  type = string
}

variable "keys" {
  type = map(object({
    gke = bool
  }))
}
