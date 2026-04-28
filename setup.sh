#! /bin/bash

# one-off runs -- background setup
# apt install debian-archive-keyring # change this to the appropriate keyring for your distro
git clone https://github.com/systemd/mkosi.git # pull mkosi if it's not there already
git clone https://github.com/Jeffrey-Sardina/systemd.git # pull the fork of systemd if it's not there already
git clone https://github.com/systemd/systemd.git # pull base systemd -- we run tests here too, to see if errors observed are present upstream or unique to Liberated systemd
cd systemd/
git remote add upstream https://github.com/systemd/systemd.git

# these repos are only ever pushed to
git remote add gitea https://gitea.com/Jeffrey-Sardina/systemd.git
git remote add codeberg https://codeberg.org/Jeffrey-Sardina/systemd.git
