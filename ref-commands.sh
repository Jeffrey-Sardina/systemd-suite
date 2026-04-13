exit
# this file is for reference -- not meant to be run

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
../mkosi/bin/mkosi -f box -- meson test -C build --print-errorlogs -q
../mkosi/bin/mkosi -f box -- meson compile -C build mkosi
sudo ../mkosi/bin/mkosi vm
