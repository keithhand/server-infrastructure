output "lb_ip" {
  value = digitalocean_kubernetes_cluster.k8_cluster.ipv4_address
}

output "kube_config" {
  value = digitalocean_kubernetes_cluster.k8_cluster.kube_config[0]
}