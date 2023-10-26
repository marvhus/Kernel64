#!/usr/bin/env bash

set -xe

{ echo "===== Cleaning"; } 2> /dev/null
./clean.sh
{ echo "===== Installing Limine"; } 2> /dev/null
./install-limine.sh
{ echo "===== Compiling kernel"; } 2> /dev/null
jai first.jai
{ echo "===== Creating ISO"; } 2> /dev/null
./make-iso.sh
{ echo "===== Running"; } 2> /dev/null
./run.sh
