resource "digitalocean_ssh_key" "Terraform" {
  name       = "Terraform"
  public_key = "${file("/home/_Tibbles__/.ssh/Terraform.pub")}"
}
data "digitalocean_ssh_key" "Ipad"{
    name = "Ipad"
}
data "digitalocean_ssh_key" "Iphone"{
    name = "Iphone"
}
data "digitalocean_ssh_key" "WebApplications"{
    name = "WebApplications"
}

