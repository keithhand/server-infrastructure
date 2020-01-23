module "digital_ocean" {
    source = "./digital_ocean"
    cluster_node_count = 2
}

module "cloudflare" {
    source = "./cloudflare"

    token = var.cloudflare_token
    non_proxied_route = "noproxy"
    main_server_ip = module.digital_ocean.lb_ip
}

module "k8" {
    source = "./kubernetes"
    host = module.digital_ocean.lb_ip
    token = module.digital_ocean.kube_config.token
    ca_cert = module.digital_ocean.kube_config.cluster_ca_certificate
}