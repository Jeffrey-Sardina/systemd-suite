# one-off runs
# apt install debian-archive-keyring # for some reason mkosi does not like ubuntu-keyring (?)
# git clone https://github.com/systemd/mkosi.git # pull mkosi if it's not there already
# git clone https://github.com/Jeffrey-Sardina/systemd.git # pull the fork of systemd if it's not there already

# update mkosi
cd mkosi
git pull

# make sure we are up to date on liberated systemd
cd ../systemd
git pull # this pulls from my fork (https://github.com/Jeffrey-Sardina/systemd)

# run tests (see: https://systemd.io/HACKING/)
../mkosi/bin/mkosi -f genkey
../mkosi/bin/mkosi -f box -- meson setup build
../mkosi/bin/mkosi -f box -- meson compile -C build mkosi
sudo ../mkosi/bin/mkosi vm
