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
  default_name = "k8-${random_id.k8_id.b64_url}"
}

###
# Used in the default name. The random_id resource allows to maintain the state
# of the default name
###
resource "random_id" "k8_id" {
  byte_length = 3
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
