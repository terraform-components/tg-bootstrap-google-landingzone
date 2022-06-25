variable "network" {
  type = string
}

variable "cidr" {
  type = object({
    pods     = string
    services = string
    nodes    = string
    master   = string
  })
  default = {
    master   = "10.63.252.0/28"
    nodes    = "10.63.192.0/22"
    pods     = "10.0.0.0/14"
    services = "10.60.0.0/18"
  }
  description = <<foo
  use https://googlecloudplatform.github.io/gke-ip-address-management/ 

  Adjust it to your needs. They are likely different!

  default uses input: 
{
 "network": "10.0.0.0",
 "netmask": 10,
 "nodeNetmask": 22,
 "clusterNetmask": 14,
 "serviceNetmask": 18,
 "nodePodNetmask": "24",
 "masterNetwork": "UNIQUE",
 "locationType": "ZONAL",
 "extraZones": 1
}

With the current configuration, up to 15 isolated clusters can be created.
Each cluster will suppport:
Up to 1020 node(s) per cluster.
Up to 16384 service(s) per cluster.
Up to 110 pods per node.
Details
The node subnet will limit each cluster to a maximum of 1020 node(s).
The cluster subnet will limit each cluster to a maximum of 1024 node(s).

Caution: In the default, we used the setting for 15 clusters. This may not be what you need. Do a proper planning!
foo
}

