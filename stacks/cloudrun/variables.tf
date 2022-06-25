variable "name" {
  type = string
}

variable "service_account" {
  type = string
}

variable "invokers" {
  type    = list(string)
  default = ["allUsers"]
}

variable "ingress" {
  type    = string
  default = "internal-and-cloud-load-balancing"
}

variable "execution_environment" {
  type    = string
  default = "gen1"
}

variable "container_concurrency" {
  type    = number
  default = 100
}

variable "container_initial_image" {
  type    = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "min_scale" {
  type    = number
  default = 0
}

variable "max_scale" {
  type    = number
  default = 5
}
