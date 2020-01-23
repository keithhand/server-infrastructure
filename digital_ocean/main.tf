###
# Uses the digital ocean provider. This requires a personal access token that
# can be saved to your environment variables as DIGITALOCEAN_ACCESS_TOKEN
#
###
provider "digitalocean" {}

###
# This is used to redefine some variables to easier to use names throughout the
# module.
#
# name - Checks to see if var.name is false (not set). And either assigns that
#        variable or local.default_name.
# default_name - String to use for the default value for the name. Set here to
#                use as a private variable.
###
locals {
  name = lower(var.name ? var.name : local.default_name)
  default_name = "k8-${random_id.k8_id.hex}"
  has_persistant_storage = var.cluster_volume_size == 0 ? 0 : 1
}

###
# Used in the default name. The random_id resource allows to maintain the state
# of the default name
###
resource "random_id" "k8_id" {
  byte_length = 2

}

###
# The kubernetes cluster to launch
###
resource "digitalocean_kubernetes_cluster" "k8_cluster" {
  name    = local.name
  region  = var.region
  version = var.k8_version

  node_pool {
    name       = "${local.name}-worker-pool"
    node_count = var.cluster_node_count
    size       = var.cluster_instance_type
  }
}

###
# Creates and attaches a volume the the k8_cluster if
# cluster_persistant_storage is set true
###
data "digitalocean_droplet" "k8_node" {
  name = digitalocean_kubernetes_cluster.k8_cluster.node_pool[0].nodes[0].name
}

resource "digitalocean_volume" "k8_volume" {
  count = local.has_persistant_storage
  name                    = "${local.name}-volume"
  description             = "Volume created by Terraform for the ${local.name} k8 cluster"

  region                  = var.region
  size                    = var.cluster_volume_size
  initial_filesystem_type = var.cluster_volume_type
}

resource "digitalocean_volume_attachment" "vol_attach" {
  count = local.has_persistant_storage
  droplet_id = data.digitalocean_droplet.k8_node.id
  volume_id = digitalocean_volume.k8_volume[0].id
}
