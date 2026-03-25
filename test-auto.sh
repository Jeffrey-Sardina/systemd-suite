#! /bin/bash

# setup
echo "update mkosi -- needed for the CI tests"
cd mkosi
git pull

# echo "make sure we are up to date on Liberated systemd"
cd ../systemd
git pull # this pulls from Liberated `systemd` (https://github.com/Jeffrey-Sardina/systemd)
git fetch upstream # get the new updates from base `systemd`
git merge upstream/main -m "merge base systemd changes into Liberated systemd"

# testing (see: https://systemd.io/HACKING/)
cd systemd/
echo "do some setup for the tests"
../mkosi/bin/mkosi -f genkey
../mkosi/bin/mkosi -f box -- meson setup build

echo "actually run the tests"
../mkosi/bin/mkosi -f box -- meson compile -C build mkosi
sudo ../mkosi/bin/mkosi vm > ../vm.log & # run in the background so we can look for its output in this script
pid=$!

echo "waiting for the VM to finish (60s timeout)"
sleep 60 # give the VM time to start
kill -9 $pid

success=$(cat ../vm.log | grep "Welcome to Ubuntu 24.04.4 LTS" | wc -l)
if [[ $success -eq "1" ]]
then
    echo "So it begins."
    # TODO: code to merge / etc as wanted
else
    echo "Gondor calls for aid! Pipeline failed."
    echo $success
    # don't merge / push -- tests failed
fi