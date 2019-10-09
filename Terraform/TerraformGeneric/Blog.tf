resource "digitalocean_droplet" "docker-blog" {
  image  = "fedora-30-x64"
  name   = "Docker-blog"
  region = "fra1"
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
  tags = [ "Terraform", "blog", "imutable"]
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
    command = " echo -e \"[remote] \\n ${self.ipv4_address} \" > BLOG"
  }
  provisioner "local-exec" {
    command = " ansible-playbook -i BLOG  -u root --private-key ${var.sshPrivate} --ssh-extra-args \"-o StrictHostKeyChecking=no\"  --extra-var \"ansible_python_interpreter=/usr/bin/python3\" ../../Ansible/Cloud-Blog.yml" 
  }


}
resource "digitalocean_record" "docker-blog" {
  domain = "ghostlink.net"
  type   = "A"
  name   = "@"
  value  = "${digitalocean_droplet.docker-blog.ipv4_address}"
}