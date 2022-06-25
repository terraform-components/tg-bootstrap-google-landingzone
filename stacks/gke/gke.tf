# still a lot of todo's

resource "google_service_account" "main" {
  account_id   = format(local.name_format[var.region], "${var.name}-gke")
  display_name = format(local.name_format[var.region], "${var.name}-gke")
}

resource "google_container_cluster" "main" {
  provider        = google-beta
  name            = format(local.name_format[var.region], var.name)
  location        = var.region
  enable_tpu      = false
  resource_labels = {}

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    service_account = google_service_account.main.email
  }

  release_channel {
    channel = var.release_channel
  }

  min_master_version = var.gke_min_master_version

  vertical_pod_autoscaling {
    enabled = false
  }

  workload_identity_config {
    workload_pool = "${data.google_project.current.project_id}.svc.id.goog"
  }

  # dataplane v2
  datapath_provider = "ADVANCED_DATAPATH"

  database_encryption {
    # https://cloud.google.com/kubernetes-engine/docs/how-to/encrypting-secrets
    state    = "ENCRYPTED"
    key_name = var.kms_key_id
  }

  maintenance_policy {
    recurring_window {
      start_time = "2019-01-01T01:00:00Z"
      end_time   = "2019-01-01T05:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH"
    }

  }

  # use this tool: https://googlecloudplatform.github.io/gke-ip-address-management/ 
  subnetwork = var.subnet
  network    = var.network

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.cidr_master
    master_global_access_config {
      enabled = true
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr
      content {
        cidr_block   = cidr_blocks.value
        display_name = cidr_blocks.key
      }
    }
  }

  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  # security
  enable_shielded_nodes = true

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [node_config]
  }

}
