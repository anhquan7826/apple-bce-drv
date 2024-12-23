# MacBook Bridge/T2 Linux Driver
A driver for MacBook models 2018 and newer, implementing the VHCI (required for mouse/keyboard/etc.) and audio functionality.

The project is divided into 3 main components:
- BCE (Buffer Copy Engine) - this is what the files in the root directory are for. This estabilishes a basic communication channel with the T2. VHCI and Audio both require this component.
- VHCI - this is a virtual USB host controller; keyboard, mouse and other system components are provided by this component (other drivers use this host controller to provide more functionality, however USB drivers are not in this project's scope).
- Audio - a driver for the T2 audio interface, currently only audio output is supported.

Please note that the `master` branch does not currently support system suspend and resume.

## Requirement
<em>Copied from [T2Linux](https://wiki.t2linux.org/guides/kernel/)</em>

You will need some packages to build the kernel:
- Arch based systems: `sudo pacman --needed -S bc kmod libelf pahole cpio perl tar xz git`
- Debian based systems: `sudo apt install autoconf bc bison build-essential cpio curl debhelper dkms dwarves fakeroot flex gawk git kernel-wedge libcap-dev libelf-dev libiberty-dev libncurses-dev libpci-dev libssl-dev libudev-dev openssl python3 rsync wget xz-utils zstd`
- For other distros you will need the equivalent of these, but if you miss something you'll most likely get an error saying what's missing, and you can then install it and re-run make to continue where you left off.

You will need about 20GB of disk space to compile the kernel. If you have a large amount of ram, you could use tmpfs to store build files in ram.

## Building
```
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
```

Credit: MCMrARM. Support him here: [Paypal](https://paypal.me/mcmrarm)
