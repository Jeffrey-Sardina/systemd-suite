#! /bin/bash

# this file is for reference -- not meant to be run
echo "This file is just for reference. It's not meant to be run. Exiting."
exit

# conda env
conda activate sysd

# one-off runs -- background setup
apt install debian-archive-keyring # for some reason mkosi does not like ubuntu-keyring (?)
git clone https://github.com/systemd/mkosi.git # pull mkosi if it's not there already
git clone https://github.com/Jeffrey-Sardina/systemd.git # pull the fork of systemd if it's not there already

# update mkosi -- needed for the CI tests
cd mkosi
git pull

# make sure we are up to date on liberated systemd
cd ../systemd
git pull # this pulls from Liberated `systemd` (https://github.com/Jeffrey-Sardina/systemd)
git fetch upstream # get the new updates from base `systemd`
git merge upstream/main # manually read through the commit notes before doing this to make sure no more surveillance is being added!

# testing (see: https://systemd.io/HACKING/)
## do some setup for the tests
## if these fail, it's probably an issue outside of Liberated systemd
../mkosi/bin/mkosi -f genkey
../mkosi/bin/mkosi -f box -- meson setup build --wipe # --wipe to forces it to re-build from scratch

## actually run the tests
## if these fail, it's probably an issue within Liberated systemd
## check against upstream (unmodified) to see if the error exists there
## other possibl;e failure sources include: out-of-date MKOSI or not activating
## the `sysd` conda  environment with Python dependencies installed.
## also note that in some cases, the cached files under `./pkg/arch/` (or
## whatever it is for your OS) can cause build issues. If you run into weird
## errors, try manually deleting those. You can make the output less verbose by
## removing --debug fromthe firstcommand -- but that is,as you would imagine,
## useful ifyou need to debug.
../mkosi/bin/mkosi --debug -f box -- meson compile -C build mkosi
../mkosi/bin/mkosi -f box -- meson test -C build --print-errorlogs -q

## note: if this aboive fails, you might need to manually load kmod with
## `sudo modprobe kvm_intel` or `sudo modprobe kvm_amd`; see:  
##    - https://wiki.archlinux.org/title/KVM
##    - https://wiki.archlinux.org/title/Kernel_module#Manual_module_handling
## you can later unload this with `sudo modprobe -r kvm_intel # or kvm_amd`
sudo ../mkosi/bin/mkosi vm
