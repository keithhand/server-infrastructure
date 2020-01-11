module "linode" {
    source = "./linode"

    token = var.linode_token
    instance_type = var.instance_type
    region = var.linode_region
}

module "cloudflare" {
    source = "./cloudflare"

    token = var.cloudflare_token
    non_proxied_route = var.non_proxied_route
    main_server_ip = module.linode.instance_ip_address
}
