#! /bin/bash

# NOTE: this code is not in use yet

# This is some of the hackiest code I have written. I don't like it.
# That said, it's (slowly) getting closer to a minimal system for
# automating testing. Once I have that, I'll look at making it a bit
# (well, a lot!) less hacky.

# Here's the idea -- running these commands as root leads to permissions
# conflicts if your directory is not itself owned and managed by root.
# And only one command in this file actually requires admin privileges.
# So, we run commands as a 'regular user' -- except the one that needs
# admin privileges.
NON_ROOT_USER=$1

# We get these as absolute paths, so we don't need to worry if we `cd`
SETUP_LOG_FILE=$(realpath ./test-setup.log) 
BUILD_LOG_FILE=$(realpath ./test-build.log)
VM_LOG_FILE=$(realpath ./test-vm.log)
SYSTEMD_PATH=$(realpath ./systemd)
MKOSI_DIR=$(realpath ./mkosi)

# we want to clear the logs before this run
CURR_DATE=$(date)
su - $NON_ROOT_USER -c "echo 'process started at: $CURR_DATE' > $SETUP_LOG_FILE"
su - $NON_ROOT_USER -c "echo 'process started at: $CURR_DATE' > $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "echo 'process started at: $CURR_DATE' > $VM_LOG_FILE"

# setup
echo "update mkosi -- needed for the CI tests"
su - $NON_ROOT_USER -c "cd $MKOSI_DIR && git pull &>> $SETUP_LOG_FILE"

# echo "make sure we are up to date on Liberated systemd"
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && git pull &>> $SETUP_LOG_FILE" # this pulls from Liberated `systemd`
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && git fetch upstream &>> $SETUP_LOG_FILE" # get the new updates from base `systemd`
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && git merge upstream/main -m 'merge base systemd changes into Liberated systemd' &>> $SETUP_LOG_FILE"

# testing (see: https://systemd.io/HACKING/)
echo "run through the CI pipeline"
su - $NON_ROOT_USER -c "echo '>>>>>>>>>>> mkosi -f genkey >>>>>>>>>>>' &>> $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && $MKOSI_DIR/bin/mkosi -f genkey &>> $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "echo '>>>>>>>>>>> mkosi -f box -- meson setup build >>>>>>>>>>>' &>> $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && $MKOSI_DIR/bin/mkosi -f box -- meson setup build &>> $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "echo '>>>>>>>>>>> mkosi -f box -- meson compile -C build mkosi >>>>>>>>>>>' &>> $BUILD_LOG_FILE"
su - $NON_ROOT_USER -c "cd $SYSTEMD_PATH && $MKOSI_DIR/bin/mkosi -f box -- meson compile -C build mkosi &>> $BUILD_LOG_FILE"
cd $SYSTEMD_PATH && $MKOSI_DIR/bin/mkosi vm &>> $VM_LOG_FILE & # run in the background so we can look for its output in this script
pid=$!

echo "waiting for the VM to finish (60s timeout)"
sleep 60 # give the VM time to start
kill -9 $pid

success=$(cat $VM_LOG_FILE | grep "Welcome to Ubuntu 24.04.4 LTS" | wc -l)
if [[ $success -gt "0" ]]
then
    echo "So it begins."
    # TODO: code to push / etc as wanted
else
    echo "Gondor calls for aid! Pipeline failed."
    echo $success
    # don't merge / push -- tests failed
fi
