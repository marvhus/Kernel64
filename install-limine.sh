#!/usr/bin/env bash

set -xe

[[ -d "./limine" ]] && rm -rf ./limine

git clone https://github.com/limine-bootloader/limine.git --branch=v5.x-branch-binary --depth=1

make -C limine
