variable "do_token" {}
variable "sshPublic" {}
variable "sshPrivate" {}



provider "digitalocean" {
  token = "${var.do_token}"
}


