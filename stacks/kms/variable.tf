variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "keys" {
  type        = list(string)
  description = "Name of your keys"
}

variable "service_identities" {
  type        = map(list(string))
  description = "Service identities for the key."
}
