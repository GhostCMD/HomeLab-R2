#!/bin/sh

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export RESTIC_PASSWORD=
export RESTIC_REPOSITORY=s3:https://s3-cold.core.ghostlink.net/backups


restic backup --tag bitwarden /mnt/appdata/bitwarden-data/
restic backup --tag firefly /mnt/appdata/firefly_iii/ 
restic backup --tag unifi /mnt/appdata/unifi/ 

#restic forget --keep-last 3 --keep-weekly 7 --keep-monthly 6 --keep-yearly 2 --tag unifi --prune
#restic forget --keep-last 6 --keep-daily 6 --keep-weekly 6 --keep-monthly 12 --keep-yearly 8 --tag firefly --prune 
#restic forget --keep-last 18 --keep-daily 12 --keep-weekly 24 --keep-monthly 48 --keep-yearly 32 --tag bitwarden  --prune 