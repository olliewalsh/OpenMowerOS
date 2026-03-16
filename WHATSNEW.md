# OpenMowerOS v2.x — What’s new (2025-09-14)

This document highlights the most relevant changes compared to previous OpenMowerOS images.


## 🆕 New

- 🖥️ [Dockge](https://dockge.kuma.pet/) GUI for container management.
- 🖥️ WebTerminal [ttyd](https://tsl0922.github.io/ttyd/) provides a browser-based shell as a lightweight SSH alternative.
- 🧰 Unified `openmower` CLI for configure, pull, start, stop, status, shell, logs, …
- 🗂️ Consolidated storage layout: configs, maps, logs now in `/home/openmower`.
- 🧾 Version metadata at `/usr/share/openmoweros/version.{json,yaml,sh,txt}` (git hash, branch, describe, build timestamp).


## ♻️ Changed / Improved

- ⚙️ Key settings (e.g. WLAN SSID & password) configurable directly in Raspberry Pi Imager.
- ✍️ No need to pre-edit files like `/boot/openmower/openmower_version.txt` before first boot.
- 🚀 Eliminated initial large image pull.
- 👤 Containers run with `openmower` user permissions (no sudo needed for most operations).


## 🛠️ Under the hood (for the curious)

- 🐧 Debian Trixie (arm64) images built with [pi‑gen](https://github.com/RPi-Distro/pi-gen).
- 📁 `openmower` CLI command is in `/usr/local/bin`.
- 🐳 OpenMower stack: Mosquitto and OpenMowerApp (together with a small Nginx) now run as separate containers and are no longer built into the open_mower_ros image.
- 📶 WLAN is managed by iwd plus Comitup.
- 🔌 LAN is managed by ifupdown.
- 📡 DHCP for the internal (xCore) LAN is handled by dnsmasq.
- 🧠 dnsmasq is also used for DNS caching and is managed by the resolvconf package.
- 🔗 LAN can now be plugged into the home network.
- 🌐 Standalone `webterminal.service` systemd unit launches the ttyd stack independently from Dockge.


---
If you spot issues or have suggestions, please open an issue or PR. 🙏
