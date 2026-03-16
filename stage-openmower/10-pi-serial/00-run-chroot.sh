#!/bin/bash -ex

# Build and install the latest upstream slattach from net-tools.
NET_TOOLS_REPO="https://github.com/ecki/net-tools.git"
NET_TOOLS_COMMIT="701161795e87a3b475afd7e3eb27885332cd90cb"
BUILD_DIR="$(mktemp -d)"

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends build-essential gettext git

git clone "$NET_TOOLS_REPO" "$BUILD_DIR/net-tools"
git -C "$BUILD_DIR/net-tools" checkout "$NET_TOOLS_COMMIT"

cd "$BUILD_DIR/net-tools"
printf '\n%.0s' $(seq 1 64) | make config
make slattach
install -m 0755 slattach /usr/local/sbin/slattach

cd /
rm -rf "$BUILD_DIR"

# Remove any serial console entries while preserving the rest of the line
sed -i -E 's/(^| )console=(serial0|ttyAMA0|ttyS0)(,[0-9]+)?//g' /boot/firmware/cmdline.txt
# Collapse multiple spaces and trim
awk '{$1=$1; print}' /boot/firmware/cmdline.txt > /boot/firmware/cmdline.txt.tmp && mv /boot/firmware/cmdline.txt.tmp /boot/firmware/cmdline.txt

# Mask and stop serial getty instances that could grab ttyAMA[0-4] (or its common aliases)
for n in 0 1 2 3 4; do
    for svc in "serial-getty@ttyAMA${n}"; do
        systemctl disable "$svc.service"
        systemctl mask "$svc.service"
    done
done
for svc in serial-getty@ttyS0 serial-getty@serial0; do
    systemctl disable "$svc.service"
    systemctl mask "$svc.service"
done

exit 0
