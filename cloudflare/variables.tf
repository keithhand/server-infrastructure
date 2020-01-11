/**
  These variable are private and should never be committed
*/

variable "token" {
  description = "Token to access linode api"
  type = string
}

// TODO: setup vpn to not expose this route public at all
variable "non_proxied_route" {
  description = "private route allow direct access to instance ip"
  type = string
}

/**
  These variables are public
*/

variable "main_server_ip" {
  description = "IP address to point A record to"
  type = string
}
