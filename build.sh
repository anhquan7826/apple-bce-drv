#!/bin/bash
set -e

mkdir build && cd build
git clone --depth=1 https://github.com/t2linux/linux-t2-patches patches

pkgver=$(curl -sL https://github.com/t2linux/T2-Ubuntu-Kernel/releases/latest/ | grep "<title>Release" | awk -F " " '{print $2}' | cut -d "v" -f 2 | cut -d "-" -f 1)
_srcname=linux-${pkgver}
wget https://www.kernel.org/pub/linux/kernel/v${pkgver//.*}.x/linux-${pkgver}.tar.xz
tar xf $_srcname.tar.xz
cd $_srcname

for patch in ../patches/*.patch; do
    patch -Np1 < $patch
done