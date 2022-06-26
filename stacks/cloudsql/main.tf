resource "google_sql_database_instance" "db" {

  deletion_protection = true

  provider            = google-beta
  name                = format(local.name_format[var.region], var.name)
  database_version    = var.database_version
  encryption_key_name = var.kms_key_id

  settings {
    tier              = var.tier
    availability_type = var.availability_type

    dynamic "database_flags" {
      for_each = toset(var.iam_authentication ? ["foo"] : [])
      content {
        name  = "cloudsql.iam_authentication"
        value = "on"
      }
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "02:00"
      transaction_log_retention_days = var.transaction_log_retention_days
      backup_retention_settings {
        retained_backups = var.retained_backups
      }
    }

    dynamic "ip_configuration" {
      for_each = toset(var.network != null ? ["foo"] : [])
      content {
        ipv4_enabled    = true
        private_network = var.network
        require_ssl     = true
      }
    }
  }
}
