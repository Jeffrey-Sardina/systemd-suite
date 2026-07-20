# this file is for reference -- not meant to be run
echo "This file is just for reference. It's not meant to be run. Exiting."
exit

# install all the packages we are going to need
apt update
apt install -y git python3 python3-pefile python3-jinja2 debian-archive-keyring sudo

# Basically -- mkosi does not like being run as root. This gives us 2 options:
# 1) modify mkosi commands, or 2) don't run as root. The second is a lot
# easier, and does not require maintaining any mkosi changes over time.
# I know there's a better way to do this with podman-compose. But for now, as
# hacky as this is -- it's simple, and it works.
useradd sysd
usermod -aG sudo sysd
echo "sysd ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/passwordless-sudo
chown -R sysd workspace/
mkdir /home/sysd/
chown -R sysd /home/sysd/
su sysd

# all our ref commands assume we are in the liberated systemd folder
cd /workspace/systemd

# from this point, run the following. See `ref-commands-update.sh` for details
# and debugging tips on these.
../mkosi/bin/mkosi -f genkey
../mkosi/bin/mkosi -f box -- meson setup build --wipe
../mkosi/bin/mkosi --debug -f box -- meson compile -C build mkosi
../mkosi/bin/mkosi -f box -- meson test -C build --print-errorlogs -q
sudo ../mkosi/bin/mkosi vm
