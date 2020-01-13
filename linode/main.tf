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

resource "null_resource" "docker_machine" {
  triggers = {
    ip_address = linode_instance.server.ip_address
    label = linode_instance.server.label
  }

  provisioner "local-exec" {
    when = create
    command = "yes | docker-machine rm ${self.triggers.label}"
  }

  provisioner "local-exec" {
    environment = {
      GENERIC_IP_ADDRESS = self.triggers.ip_address
      GENERIC_SSH_USER = "root"
    }
    command = "docker-machine create -d generic ${self.triggers.label}"
  }
}

resource "null_resource" "ansible" {
  count = 0
// TODO: Add ansible call
//  provisioner "remote-exec" {
//    connection {
//      host = linode_instance.server.ip_address
//      user = "root"
//      private_key = file(var.ssh_key_path)
//    }
//  }
}
