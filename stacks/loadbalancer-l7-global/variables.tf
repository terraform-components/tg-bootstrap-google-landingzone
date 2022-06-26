variable "name" {
  type = string
}

variable "domains" {
  type        = map(list(string))
  description = "map of list to have multiple certificates"
}

variable "cdn" {
  type    = bool
  default = false
}

variable "backend_network_endpoint_group_id" {
  type = string
}
