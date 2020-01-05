module "linode" {
    source = "./linode"

    token = var.linode_token
    instance_type = var.instance_type
    region = var.region
}

module "cloudflare" {
    source = "./cloudflare"

    token = var.cloudflare_token
    linode_ip = module.linode.instance_ip_address
}
