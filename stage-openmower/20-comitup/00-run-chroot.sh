#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
    git \
    iw \
    iwd \
    python3-cachetools \
    python3-cairo \
    python3-dbus \
    python3-flask \
    python3-gi \
    python3-networkmanager \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    rfkill

systemctl enable comitup.service
systemctl enable comitup-iwd-wifi-ensure.service
systemctl enable iwd.service

systemctl mask NetworkManager.service
systemctl mask NetworkManager-wait-online.service
systemctl mask wpa_supplicant.service
systemctl mask wpa_supplicant@.service

TMPDIR="$(mktemp -d)"
git clone --depth 1 --branch iwd_backend https://github.com/olliewalsh/comitup.git "$TMPDIR/comitup"
python3 -m pip install --break-system-packages --no-deps "$TMPDIR/comitup"
rm -rf "$TMPDIR"

if ! grep -q '^ap_name:' /etc/comitup.conf 2>/dev/null; then
    printf '\n# Default OpenMower AP name for provisioning\nap_name: OpenMower-<nnn>\n' >> /etc/comitup.conf
fi

# Use the iwd backend explicitly.
if grep -q '^#\s*network_backend:' /etc/comitup.conf 2>/dev/null; then
    sed -i 's/^#\s*network_backend:.*/network_backend: iwd/' /etc/comitup.conf
elif ! grep -q '^network_backend:' /etc/comitup.conf 2>/dev/null; then
    printf '\n# Use iwd for Wi-Fi management\nnetwork_backend: iwd\n' >> /etc/comitup.conf
fi

# Enable external_callback to manage dnsmasq
sed -i 's/^#\s*external_callback:.*/external_callback: \/usr\/local\/bin\/comitup-callback/' /etc/comitup.conf
chown -R root:root /usr/local/bin/comitup-callback
