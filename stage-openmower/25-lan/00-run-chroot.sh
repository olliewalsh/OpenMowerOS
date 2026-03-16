#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive

systemctl mask systemd-networkd-wait-online.service

cat >> "/etc/dhcpcd.conf" <<'EOF'

#
# OpenMower specific
#

# Keep dhcpcd away from Wi-Fi so iwd can manage wlan addressing itself.
denyinterfaces wlan*

# dhcpcd is only used for eth0 (ifupdown)
interface eth0

# Don't touch resolv.conf...
# (matches full name, or prefixed with 2 numbers optionally ending with .sh)
nohook resolv.conf

# ... instead of send DNS-Informationen to resolvconf
option domain_name_servers domain_name domain_search
EOF

ln -sf /run/resolvconf/resolv.conf /etc/resolv.conf
