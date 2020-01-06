provider "linode" {
  token = var.token
}

locals {
  server_name = "main"
}

resource "linode_instance" "main_server" {
  image = "private/7992300"
  label = "${local.server_name}-server"
  group = "Personal"
  region = var.region
  type = var.instance_type
  authorized_users = [ "rkeithhand" ]
}
