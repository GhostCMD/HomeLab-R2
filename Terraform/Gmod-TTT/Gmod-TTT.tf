data "digitalocean_ssh_key" "Terraform" {
  name       = "Terraform"
  #public_key = "${file(var.sshPublic)}"
}
data "digitalocean_image" "Ubuntu-Gmod" {
  name = "Ubuntu-Gmod"
}

data "digitalocean_ssh_key" "Miho" {
  name = "Miho"
}
data "digitalocean_ssh_key" "Iphone" {
  name = "Iphone"
}
data "digitalocean_ssh_key" "Ipad" {
  name = "Ipad"
}
resource "digitalocean_droplet" "Gameserver-TTT"{
    image = "${data.digitalocean_image.Ubuntu-Gmod.image}"
    name = "Temporal-Gmod"
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
    provisioner "remote-exec" {
        inline = [ "sudo -u gameserver screen -S Gmod \"/home/steam/Server1/srcds_run -game garrysmod +maxplayers 12 +map  ttt_atlantis_v3  +gamemode terrortown -console +host_workshop_collection 2035305813\"" ]
    }

    provisioner "local-exec" {
        command = "echo -e \"[remote] \\n ${self.ipv4_address} \" > hosts"
    }
    
}
resource "digitalocean_record" "Gameserver-TTT-DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "TTT.Games"
  ttl    = "600"
  value  = "${digitalocean_droplet.Gameserver-TTT.ipv4_address}"
}

resource "digitalocean_record" "Gameserver-TTT-DNSv6" {
  domain = "ghostlink.net"
  type   = "AAAA"
  name   = "TTT.Games"
  ttl    = "600"
  value  = "${digitalocean_droplet.Gameserver-TTT.ipv6_address}"
}
