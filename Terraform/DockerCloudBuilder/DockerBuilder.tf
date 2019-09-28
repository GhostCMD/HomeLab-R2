resource "digitalocean_ssh_key" "Terraform" {
  name       = "Terraform"
  public_key = "${file(var.sshPublic)}"
}

resource "digitalocean_droplet" "DockerBuilder"{
    image = "ubuntu-18-04-x64"
    name = "Builder"
    region = "lon1"
    size = "s-4vcpu-8gb"
    private_networking = false
    monitoring = true
    ipv6 = false 
    ssh_keys = [
      "${digitalocean_ssh_key.Terraform.fingerprint}","77:c9:04:70:c1:15:47:a0:0d:34:08:35:61:54:33:2b","ee:63:7e:7e:87:42:9b:4d:bc:ad:59:09:27:6d:78:99"
#        "f7:43:60:f3:67:ab:ba:b7:3d:7d:c7:a1:f3:3d:0d:7c"
    ]
    tags = ["Terraform","Tempory"]
    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.sshPrivate)}"
      host     = "${self.ipv4_address}"
    }

    provisioner "remote-exec" {
        inline = [ "date > /InitDateTime.txt" ]
    }
    
}
resource "digitalocean_record" "DockerBuilder_DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "builder.dev"
  value  = "${digitalocean_droplet.DockerBuilder.ipv4_address}"
}
