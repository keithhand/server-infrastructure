provider "cloudflare" {
    version = "~> 2.0"
    api_token = var.token
}

locals {
    keithhand_dev_id = "5dd843d66f2e903eed8150d99d7039c6"
    keithhand_dev_name = "keithhand.dev"
    hand_technology_id = "2d11995f2e5b049ae67b8ef00e8a664e"
    hand_technology_name = "hand.technology"

    direct_route_cname = "evdbuuskdlkd"

    zones = {
        "${local.keithhand_dev_id}" = "${local.keithhand_dev_name}"
        "${local.hand_technology_id}" = "${local.hand_technology_name}"
    }
}

resource "cloudflare_record" "keithhand_dev_a_record" {
    zone_id = local.keithhand_dev_id
    name = local.keithhand_dev_name
    value = var.linode_ip
    type = "A"
    ttl = 1
    proxied = true
}

resource "cloudflare_record" "hand_technology_to_keithhand_dev" {
    zone_id = local.hand_technology_id
    name = local.hand_technology_name
    value = local.keithhand_dev_name
    type = "CNAME"
    ttl = 1
    proxied = true
}

resource "cloudflare_record" "www_redirects" {
    for_each = local.zones
    zone_id = each.key
    name = "www"
    value = each.value
    type = "CNAME"
    ttl = 1
    proxied = true
}

resource "cloudflare_record" "non_proxied_route" {
    zone_id = local.keithhand_dev_id
    name = local.direct_route_cname
    value = var.linode_ip
    type = "A"
    ttl = 300
    proxied = false
}
