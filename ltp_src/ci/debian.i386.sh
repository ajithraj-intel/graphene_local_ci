#!/bin/sh -eux
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
# GSGX-4932: Added -u flag in the shebang

dpkg --add-architecture i386
apt update

apt install -y --no-install-recommends \
	linux-libc-dev:i386 \
	gcc-multilib \
	libacl1-dev:i386 \
	libaio-dev:i386 \
	libcap-dev:i386 \
	libc6-dev-i386 \
	libc6:i386 \
	libkeyutils-dev:i386 \
	libnuma-dev:i386 \
	libssl-dev:i386 \
	libtirpc-dev:i386 \
	pkg-config:i386

# GSGX-4932: Added -dev in few packages
