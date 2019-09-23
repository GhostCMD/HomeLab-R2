variable "do_token" {}
variable "sshPublic" {}
variable "sshPrivate" {}
#variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
data "digitalocean_ssh_key" "Terraform" {
  name = "Terraform"
}

