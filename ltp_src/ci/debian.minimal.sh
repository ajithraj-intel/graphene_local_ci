#!/bin/sh -eux
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>

ACTION="remove-nonessential" $(dirname $0)/debian.sh

# GSGX-4932: Added -u flag in the shebang
# GSGX-4932: The removal of packages is now automated instead of manual
