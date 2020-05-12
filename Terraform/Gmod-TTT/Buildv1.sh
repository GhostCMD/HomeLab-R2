#!/usr/bin/expect -f

set timeout -1
spawn  terraform apply --target=digitalocean_droplet.Gameserver-TTT --target=digitalocean_record.Gameserver-TTT-DNS --target=digitalocean_record.Gameserver-TTT-DNSv6

expect "Enter a value:"
send  "yes\n"
expect eof

