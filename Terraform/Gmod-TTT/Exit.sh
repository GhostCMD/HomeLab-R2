#!/bin/sh
terraform destroy --target=digitalocean_droplet.Gameserver-TTT --target=digitalocean_record.Gameserver-TTT-DNS --target=digitalocean_record.Gameserver-TTT-DNSv6
