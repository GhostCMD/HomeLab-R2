resource "digitalocean_ssh_key" "Terraform" {
  name       = "Terraform"
  public_key = "${file(var.sshPublic)}"
}
data "digitalocean_image" "Docker-Builder" {
  name = "DockerBuilder"
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
resource "digitalocean_droplet" "DockerBuilder"{
    image = "${data.digitalocean_image.Docker-Builder.image}}"
    name = "Builder"
    region = "lon1"
    size = "s-4vcpu-8gb"
    private_networking = false
    monitoring = true
    ipv6 = false 
    ssh_keys = [
      "${digitalocean_ssh_key.Terraform.fingerprint}",
      "${data.digitalocean_ssh_key.Ipad.fingerprint}",
      "${data.digitalocean_ssh_key.Iphone.fingerprint}",
      "${data.digitalocean_ssh_key.Miho.fingerprint}"
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

     provisioner "local-exec" {
        command = "echo -e \"[remote] \\n ${self.ipv4_address} \" > hosts"
    }

    provisioner "local-exec" {
      command = " #ansible-playbook -i hosts  -u ServiceLink --private-key ${var.sshPrivateService} --ssh-extra-args \"-o StrictHostKeyChecking=no\" --extra-var \"ansible_python_interpreter=/usr/bin/python3\" ../../Ansible/Terraform-Clone-Containers.yaml" 
    }
    
}
resource "digitalocean_record" "DockerBuilder_DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "builder.dev"
  ttl    = "600"
  value  = "${digitalocean_droplet.DockerBuilder.ipv4_address}"
}
