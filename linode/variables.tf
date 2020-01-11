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
