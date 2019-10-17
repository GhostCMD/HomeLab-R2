resource "digitalocean_droplet" "ShellLink" {
  image  = "fedora-30-x64"
  name   = "ShellLink"
  region = "lon1"
  size   = "s-1vcpu-1gb"
  monitoring = true
  ipv6 = false
  ssh_keys = [
      "${data.digitalocean_ssh_key.Terraform.fingerprint}",
      "${data.digitalocean_ssh_key.Ipad.fingerprint}",
      "${data.digitalocean_ssh_key.Iphone.fingerprint}",
      "${data.digitalocean_ssh_key.WebApplications.fingerprint}",
      "${data.digitalocean_ssh_key.Miho.fingerprint}"

  ]
  tags = [ "Terraform", "cnc", "Mobile"]
  connection {
    type     = "ssh"
    user     = "root"
    private_key = "${file(var.sshPrivate)}"
    host     = "${self.ipv4_address}"
  }
  provisioner "remote-exec" {
    inline = [ "date > /InitDateTime.txt"]
  }
  provisioner "local-exec"{
    command = " echo -e \"[remote] \\n ${self.ipv4_address} \" > ShellLinkIP"
  }
  provisioner "local-exec"{
    command = " ./MoveDots.sh"
  }
  provisioner "local-exec" {
    command = " ansible-playbook -i ShellLinkIP  -u root --private-key ${var.sshPrivate} --ssh-extra-args \"-o StrictHostKeyChecking=no\" --extra-var \"ansible_python_interpreter=/usr/bin/python3\" ../../Ansible/provisionShellLink.yml" 
  }

  provisioner "local-exec"{
    command = "rm -rf /tmp/ShellLinkData"
  }
  provisioner "local-exec"{
    command = "scp -i $HOME/.ssh/WebApplications  $HOME/.ssh/Terraform.pub  GhostShell@ShellLink.ghostlink.net:/home/GhostShell/.ssh/Terraform.pub; scp -i $HOME/.ssh/WebApplications  $HOME/.ssh/Terraform  GhostShell@ShellLink.ghostlink.net:/home/GhostShell/.ssh/Terraform"
  }
}
resource "digitalocean_record" "ShellLink_DNS" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "ShellLink"
  value  = "${digitalocean_droplet.ShellLink.ipv4_address}"
}