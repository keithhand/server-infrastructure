variable "cluster_node_count" {
  description = "The total number of instances desired to run as nodes. Recommended >2 for running updates."
  type = string
  default = 3
}

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
  default = "1.16.2-do.3"
}

variable "cluster_instance_type" {
  description = "The type of digital ocean droplets the nodes should be ran on."
  type = string
  default = "s-1vcpu-2gb"
}

variable "cluster_volume_size" {
  description = "The amount of volume storage to allocate to the cluster."
  type = number
  default = 0
}

variable "cluster_volume_type" {
  description = "The filesystem type to give the volume"
  type = string
  default = "ext4"
}
