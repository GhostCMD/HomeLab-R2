#!/usr/bin/expect -f

set timeout -1
spawn  terraform destroy --target=digitalocean_droplet.Gameserver-TTT2 --target=digitalocean_record.Gameserver-TTT2-DNS --target=digitalocean_record.Gameserver-TTT2-DNSv6

expect "Enter a value:"
send  "yes\n"
expect eof

