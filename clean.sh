#!/usr/bin/env bash

[[ -d "./limine"   ]] && rm -rf ./limine
[[ -d "./.build"   ]] && rm -rf ./.build
[[ -d "./bin"      ]] && rm -rf ./bin
[[ -d "./iso_root" ]] && rm -rf ./iso_root
[[ -d "./boot"     ]] && rm -rf ./boot
exit 0
