data "digitalocean_image" "Ubuntu-Gmod2" {
  name = "Ubuntu-Gmod2-Next"
}

resource "digitalocean_droplet" "Gameserver-TTT2"{
    image = "${data.digitalocean_image.Ubuntu-Gmod2.image}"
    name = "Temporal-Gmod2"
    region = "lon1"
    size = "c-4"
    private_networking = false
    monitoring = true
    ipv6 = true 
    ssh_keys = [
      "${data.digitalocean_ssh_key.Terraform.fingerprint}",
      "${data.digitalocean_ssh_key.Ipad.fingerprint}",
      "${data.digitalocean_ssh_key.Iphone.fingerprint}",
      "${data.digitalocean_ssh_key.Miho.fingerprint}"
    ]
    tags = ["Terraform","Temporal"]
    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.sshPrivate)}"
      host     = "${self.ipv4_address}"
    }

    provisioner "remote-exec" {
        inline = [ "date > /InitDateTime.txt" ]
    }
    provisioner "local-exec" {
        command = "echo -e \"[remote] \\n ${self.ipv4_address} \" > hosts"
    }
    
}
resource "digitalocean_record" "Gameserver-TTT2-DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "TTT2.Games"
  ttl    = "600"
  value  = "${digitalocean_droplet.Gameserver-TTT2.ipv4_address}"
}

resource "digitalocean_record" "Gameserver-TTT2-DNSv6" {
  domain = "ghostlink.net"
  type   = "AAAA"
  name   = "TTT2.Games"
  ttl    = "600"
  value  = "${digitalocean_droplet.Gameserver-TTT2.ipv6_address}"
}
