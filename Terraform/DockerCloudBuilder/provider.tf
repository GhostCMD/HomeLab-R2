variable "do_token" {}
variable "sshPublic" {}
variable "sshPrivate" {}
variable "sshPrivateService" {}


provider "digitalocean" {
  token = "${var.do_token}"
}


