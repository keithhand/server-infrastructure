/**
  These variable are private and should never be committed
*/

variable "token" {
  description = "Token to access linode api"
  type = string
}

/**
  These variables are public
*/

variable "server_name" {
  description = "Main identifier for the instance"
  type = string
  default = "main"
}

variable "image" {
  description = "Image to use for the instance"
  type = string
  default = "linode/debian10"
}

variable "instance_type" {
  description = "The instance size to set the server as"
  type = string
  default = "g6-standard-1"
}

variable "region" {
  description = "Region to place the instance"
  type = string
  default = "us-central-1"
}

variable "authorized_users" {
  description = "List of linode users to be authorized ssh access"
  type = list(string)
  default = [ "rkeithhand" ]
}
