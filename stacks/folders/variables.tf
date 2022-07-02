variable "org_id" {
  type = string
}

variable "environments" {
  type = map(string)
}

variable "stages" {
  type = list(string)
}
