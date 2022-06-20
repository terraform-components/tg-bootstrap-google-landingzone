output "subnets" {
  value = merge(local.subnets, {
    for subnet, sn in local.subnets :
    subnet => google_compute_subnetwork.sn[subnet].id
  })

}
