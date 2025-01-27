#!/bin/sh -eux
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2019-2022 Petr Vorel <petr.vorel@gmail.com>

# GSGX-4932: Add -u flag in the first line

apk update

apk add \
	acl-dev \
	asciidoc \
	asciidoctor \
	autoconf \
	automake \
	clang \
	gcc \
	git \
	keyutils-dev \
	libaio-dev \
	libacl \
	libcap-dev \
	libselinux-dev \
	libsepol-dev \
	libtirpc-dev \
	linux-headers \
	make \
	musl-dev \
	numactl-dev \
	openssl-dev \
	perl-json \
	pkgconfig

cat /etc/os-release

echo "WARNING: remove unsupported tests (until they're fixed)"
cd $(dirname $0)/..
rm -rfv \
	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
	testcases/kernel/syscalls/timer_create/timer_create01.c \
	testcases/kernel/syscalls/timer_create/timer_create03.c

cd -
