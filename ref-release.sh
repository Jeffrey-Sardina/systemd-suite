#! /bin/bash

# see: https://systemd.io/RELEASE/

# this file is for reference -- not meant to be run
# it's just a list of (most) commands I'll need to manually create a release
# see further information here for manual file changes needed https://systemd.io/RELEASE/
# see: https://systemd.io/RELEASE/
# this is not ready for use yet
exit

# set up the release dir (make sure it does not exist)
release_name=$1
TARGET_DIR_NAME="systemd"
if [ -d "releases/$release_name" ]
then
    echo "ERROR: release already exists. Cancelling operation. No changes were made"
    exit
else
    mkdir releases/$release_name/
fi

# copy all files in the Liberated systemd over
# cp -r systemd/ releases/$release_name/
cp -r $TARGET_DIR_NAME releases/$release_name/

# remove files not meant to be part of the release
rm -rf releases/$release_name/$TARGET_DIR_NAME/.git/
rm -rf releases/$release_name/$TARGET_DIR_NAME/build/
rm -rf releases/$release_name/$TARGET_DIR_NAME/pkg/

# make the expected archives
# NOTE: we must manually modify some files (see https://systemd.io/RELEASE/) first
cd releases/$release_name/
zip -r "$TARGET_DIR_NAME.zip" $TARGET_DIR_NAME
tar -czvf $TARGET_DIR_NAME.tar.gz $TARGET_DIR_NAME

# calculate checksums of the release files
sum_zip=$(sha256sum $TARGET_DIR_NAME.zip)
sum_gz=$(sha256sum $TARGET_DIR_NAME.tar.gz)

# write the sums to a file to enable verification
echo "$sum_zip" > sha256sum.txt
echo "$sum_gz" >> sha256sum.txt

# NOTE: now, we need to test the release!
