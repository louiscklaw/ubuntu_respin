#!/usr/bin/env bash

set -x

wget -qO origin/ubuntu-18.04.4-desktop-amd64.iso http://releases.ubuntu.com/18.04/ubuntu-18.04.4-desktop-amd64.iso

md5sum origin/ubuntu-18.04.4-desktop-amd64.iso
