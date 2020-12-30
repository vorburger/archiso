#!/usr/bin/env bash
#
# Copyright (C) 2020 Michael Vorburger.ch <mike@vorburger.ch>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Simple script creating correct cloudinit.iso from current UID & PubKey.
# See https://wiki.archlinux.org/index.php/Cloud-init.

set -euo pipefail

userdata="$(mktemp -t user-data.XXXXXXXXXX)"

printf '#cloud-config\nusers:\n  - name: %s\n    ssh_authorized_keys:\n      - %s\n' "$USER" "$(ssh-add -L)" > "$userdata"

cloud-localds cloud-init.iso "$userdata"

rm "$userdata"

printf "cloud-init.iso successfully created (use it e.g. with run_archiso.sh -c cloud-init.iso)\n"
