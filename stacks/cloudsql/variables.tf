variable "name" {
  type = string
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "iam_authentication" {
  type    = bool
  default = true
}

variable "network" {
  type    = string
  default = null
}

variable "database_version" {
  type    = string
  default = "POSTGRES_13"
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "availability_type" {
  type    = string
  default = "ZONAL"
}

variable "retained_backups" {
  type    = number
  default = 10
}

variable "transaction_log_retention_days" {
  type    = number
  default = 1
}
