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

resource "null_resource" "docker-machine" {
  triggers = {
    server_ip = linode_instance.server.ip_address
    server_name = var.server_name
  }

  provisioner "local-exec" {
    command = "yes | docker-machine rm ${self.triggers.server_name}"
    on_failure = continue
  }

  provisioner "local-exec" {
    environment = {
      GENERIC_IP_ADDRESS = self.triggers.server_ip
      GENERIC_SSH_USER = "root"
    }

    command = "docker-machine create -d generic ${self.triggers.server_name}"
  }
}
