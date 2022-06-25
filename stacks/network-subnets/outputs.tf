output "subnets" {
  value = {
    for subnet, sn in local.subnets :
    subnet => google_compute_subnetwork.sn[subnet].id
  }
}
