#!/bin/bash -e

STAGE_DIR="$(dirname "$0")"

install -m 0644 -D \
    "$STAGE_DIR/files/etc/systemd/system/slip-link.service" \
    "$ROOTFS_DIR/etc/systemd/system/slip-link.service"
install -m 0755 -D \
    "$STAGE_DIR/files/usr/local/sbin/slip-link" \
    "$ROOTFS_DIR/usr/local/sbin/slip-link"
