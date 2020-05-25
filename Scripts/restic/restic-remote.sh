#!/bin/sh
export AZURE_ACCOUNT_NAME=pilinkrepo
export AZURE_ACCOUNT_KEY=
export RESTIC_REPOSITORY=DefaultEndpointsProtocol=https;
export RESTIC_PASSWORD=

restic -r azure:pilinkrepo:/ backup --tag bitwarden /mnt/appdata/bitwarden-data/
restic -r azure:pilinkrepo:/ backup --tag firefly /mnt/appdata/firefly_iii/ 
restic -r azure:pilinkrepo:/ backup --tag unifi /mnt/appdata/unifi/ 

restic -r azure:pilinkrepo:/ forget --keep-last 3 --keep-weekly 7 --keep-monthly 6 --keep-yearly 2 --tag unifi --prune
restic -r azure:pilinkrepo:/ forget --keep-last 6 --keep-daily 6 --keep-weekly 6 --keep-monthly 12 --keep-yearly 8 --tag firefly --prune #--path /mnt/appdata/firefly_iii/
restic -r azure:pilinkrepo:/ forget --keep-last 6 --keep-daily 6 --keep-weekly 6 --keep-monthly 12 --keep-yearly 8 --tag bitwarden --prune #--path /mnt/appdata/bitwarden-data/
