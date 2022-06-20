variable "network" {
  type = string
}

variable "cidr_subnets" {
  type = string
}

variable "subnets" {
  type = map(number)
}

variable "subnet_bits" {
  type        = number
  default     = 4
  description = "bits used for separating subnets. higher number = more subnets, but smaller. When this is 6, we have 32 possible subnets."
}
