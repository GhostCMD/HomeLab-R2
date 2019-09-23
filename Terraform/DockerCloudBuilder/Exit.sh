#!/bin/sh
terraform destroy --target=digitalocean_droplet.DockerBuilder --target=digitalocean_record.DockerBuilder_DNS
