###
#
# This section contains required variables
#
###
variable "cluster_node_count" {
  description = "The total number of instances desired to run as nodes. Recommended >2 for running updates."
  type = string
}

###
#
# This section contains variables available to be overwritten.
# However due to the nature of their use, there are appropriate
# default values to set.
#
###
variable "name" {
  description = "The identifying name used when setting up resources. Use the locals block version."
  default = false
}

variable "region" {
  description = "Region to host the cluster in."
  type = string
  default = "sfo2"
}

variable "k8_version" {
  description = "Kubernetes version to use. Recommended to use the latest version if possible."
  type = string
  default = "1.16.2-do.2"
}

variable "cluster_instance_type" {
  description = "The type of digital ocean droplets the nodes should be ran on."
  type = string
  default = "s-1vcpu-2gb"
}
