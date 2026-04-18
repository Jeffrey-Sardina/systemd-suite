#! /bin/bash

# this file is for reference -- not meant to be run
echo "This file is just for reference. It's not meant to be run. Exiting."
exit

# we assumme the release .tar.gz is in releases/
tar -xvf NAME
mv NAME NAME.nopatch

# now we apply the patch to remove surveillance enablement
# note: by default this applies to all files in the working dir
cd NAME
git apply ../../main.patch
cd ..

# after this, run the commands in `ref-commands.sh` to test the
# release. Ifthe tests pass, the proceed to compress
mkdir NAME_distribute
tar -cvzf NAME_distribute/NAME.tar.gz NAME/
zip -r NAME_distribute/NAME.zip NAME/

# create checksums for the release to be published alongside it
sha256sum NAME.tar.gz > NAME_distribute/sha256sum.txt
sha256sum NAME.zip >> NAME_distribute/sha256sum.txt

# delete the unpatched data
mv NAME NAME.nopatch
rm -rf NAME

# now, upload all of the data to Liberated systemd as a release!
