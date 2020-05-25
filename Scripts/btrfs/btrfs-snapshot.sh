#!/bin/bash
btrfs subvolume snapshot /mnt/appdata/bitwarden-data/ /mnt/appdata/.snapshots/bitwarden-$(date --iso-8601=hours)
btrfs subvolume snapshot /mnt/appdata/firefly_iii/ /mnt/appdata/.snapshots/firefly_iii-$(date --iso-8601=hours)
btrfs subvolume snapshot /mnt/appdata/nextcloud/ /mnt/appdata/.snapshots/nextcloud-$(date --iso-8601=hours)
btrfs subvolume snapshot /mnt/appdata/letsencrypt/ /mnt/appdata/.snapshots/letsencrypt-$(date --iso-8601=hours)
btrfs subvolume snapshot /mnt/appdata/mariadb/ /mnt/appdata/.snapshots/mariadb-$(date --iso-8601=hours)
btrfs subvolume snapshot /mnt/appdata/unifi/ /mnt/appdata/.snapshots/unifi-$(date --iso-8601=hours)
