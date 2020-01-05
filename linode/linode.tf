provider "linode" {
  token = var.token
}

resource "linode_instance" "main_server" {
  image = "private/7983224"
  label = "Main-Server"
  group = "Personal"
  region = var.region
  type = var.instance_type
  authorized_users = [ "rkeithhand" ]
}
