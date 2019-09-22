resource "digitalocean_ssh_key" "Terraform" {
  name       = "Terraform Example"
  public_key = "${file("/home/_Tibbles__/.ssh/Terraform.pub")}"
}
resource "digitalocean_droplet" "DockerBuilder"{
    image = "ubuntu-18-04-x64"
    name = "Builder"
    region = "lon1"
    size = "s-2vcpu-4gb"
    private_networking = false
    monitoring = true
    ipv6 = false 
    ssh_keys = [
      "${digitalocean_ssh_key.Terraform.fingerprint}"
    ]
    tags = ["Terraform"]
    
    provisioner "remote-exec" {
        inline = [ " Date > /InitDateTime.txt"]
    }
    provisioner "local-exec" {
    command = "ansible-playbook -i '${self.ipv4_address},' --private-key ${var.pvt_key}  DockerBuilder.yml"
    }
}
resource "digitalocean_record" "DockerBuilder_DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "builder.dev"
  value  = "${digitalocean_droplet.DockerBuilder.ipv4_address}"
}
