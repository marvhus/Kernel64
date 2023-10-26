#!/usr/bin/env bash

set -xe

qemu-system-x86_64 -cdrom boot/kernel64.iso
