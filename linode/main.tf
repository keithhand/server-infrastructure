provider "linode" {
  token = var.token
}

resource "linode_instance" "server" {
  image = var.image
  label = var.server_name
  region = var.region
  type = var.instance_type
  authorized_users = var.authorized_users
}
