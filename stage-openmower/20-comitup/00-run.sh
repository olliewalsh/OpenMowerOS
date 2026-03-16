#!/bin/bash -e

# Host-side installer: copy config files into the rootfs

STAGE_DIR="$(dirname "$0")"

# Install files
install -m 0644 -D "$STAGE_DIR/files/etc/iwd/main.conf" "$ROOTFS_DIR/etc/iwd/main.conf"
install -m 0644 -D "$STAGE_DIR/files/etc/systemd/system/comitup-iwd-wifi-ensure.service" "$ROOTFS_DIR/etc/systemd/system/comitup-iwd-wifi-ensure.service"
install -m 0644 -D "$STAGE_DIR/files/etc/systemd/system/comitup.service" "$ROOTFS_DIR/etc/systemd/system/comitup.service"
install -m 0644 -D "$STAGE_DIR/files/etc/systemd/system/comitup-web.service" "$ROOTFS_DIR/etc/systemd/system/comitup-web.service"
install -m 0755 -D "$STAGE_DIR/files/usr/local/bin/comitup-callback" "$ROOTFS_DIR/usr/local/bin/comitup-callback"
