# one-off runs -- background setup
# apt install debian-archive-keyring # change this to the appropriate keyring for your distro
git clone https://github.com/systemd/mkosi.git # pull mkosi if it's not there already
git clone https://github.com/Jeffrey-Sardina/systemd.git # pull the fork of systemd if it's not there already
cd systemd/
git remote add upstream https://github.com/systemd/systemd.git
