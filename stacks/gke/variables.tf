variable "master_authorized_networks_cidr" {
  type    = map(string)
  default = {}
}

variable "gke_min_master_version" {
  type = string
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}

variable "cidr_master" {
  type = string
}

variable "name" {
  type = string
}

variable "release_channel" {
  type    = string
  default = "STABLE"
}

variable "kms_key_id" {
  type = string
}
