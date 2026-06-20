#! /bin/bash

# this file is for reference -- not meant to be run
echo "This file is just for reference. It's not meant to be run. Exiting."
exit

# first, we create (or update) the git patch. Make sure that systemd-base and
# systemd are both equally up to date before running this! If you get weird
# errors, it's almost certainly because you # *think* that the two are sync'd,
# but they are not. No this did not happen to me, I've no idea what you are
# talking about...
cd systemd/
git --no-pager diff upstream/main > ../main.patch
cd ..

# we download the source code from here:
# https://github.com/systemd/systemd/releases/

# we uncompress at the source code.
# see the note below: this should be done outside a Git repo.
cd /wherever/you/downloaded/the/release/
tar -xvf NAME # this is the name of the release folder

# now we apply the patch to remove surveillance enablement
# note: by default this applies to all files in the working dir
# Also make sure that you run this *outsied* a git repo,or `git apply` will 
# get confused and not do anything useful. Or, well, not do anything at all
# more like.
cd NAME
git apply ../../main.patch
cd ..

# at this point, MANUALLY verify that birthday surveillance nonsense has been
# removed. If you want a command to run, here  you go:
echo "I have finished *manually* verifing that surveillance was removed"

# we move the source files into a `releases` directory for testing
# we need this 2x -- once to test in, one to publish
# we test in a different directory since the test creates tons of files that
# are not part of the release
mkdir releases/
cp -r /wherever/you/downloaded/the/release/ ./releases/NAME
cp -r /wherever/you/downloaded/the/release/ ./releases/replica
cd releases/replica

# after this, run the commands in `ref-commands.sh` to test the
# release. Note that the mkosi commands will need an additional `../` before
# them, since you are one more directory down. Make sure all tests pass, and
# that the created VM boots.
echo "I have finished *manually* verifying that the VM launches all tests pass"
rm -rf releases/replica # optional, but useful to avoid confusion going forward
cd ..

# if all tests pass, then it's time to build our own release packages
# note that we use the copy we did NOT run tests in, because otherwise we'll
# push over 10G of extra files into the release. This operation should be
# *very* quick -- if they take more thana couple seconds, you have likely added
# build data from your tests into thecompressed files
mkdir distribute/
tar -cvzf distribute/NAME.tar.gz NAME/

# create checksums for the release to be published alongside it
cd distribute/
sha256sum NAME.tar.gz > sha256sum.txt

# now, upload all of the data to Liberated systemd as a release!
