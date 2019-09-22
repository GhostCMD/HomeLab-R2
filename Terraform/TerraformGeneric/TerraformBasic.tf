resource "digitalocean_droplet" "ShellLink" {
  image  = "fedora-30-x64"
  name   = "ShellLink"
  region = "lon1"
  size   = "s-1vcpu-1gb"
  monitoring = true
  ipv6 = false
  ssh_keys = [
      "${digitalocean_ssh_key.Terraform.fingerprint}",
  ]
  tags = [ "Terraform", "cnc", "Mobile"]
  connection {
    type     = "ssh"
    user     = "root"
    private_key = "${file(var.pvt_key)}"
    host     = "${self.ipv4_address}"
  }
  provisioner "remote-exec" {
    inline = [ "date > /InitDateTime.txt",
	" sudo dnf update -y",
	" dnf install screen -y "
	]
  }
}
