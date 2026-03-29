# Liberated `systemd` -- testing and automation suite

This is where I manage all testing and automation related tasks for Liberated `systemd` (https://github.com/Jeffrey-Sardina/systemd). 

## The testing pipeline
Currently, this is nothing fancy. Once changes are made to the `systemd` fork, all tests in `test.sh` are run. These are the same CI tests base `systemd` requires for all pull requests (see: https://systemd.io/HACKING/). In short, this consists of creating a VM running `systemd` from the (new) source code, and verifying that it runs.

New pushes of Liberated `systemd` code are only made once tests pass.

## How to use this repo
1. Use the commands in `setup.sh` to configure the environment. Note that the first line (commended out) will vary on your OS -- make sure you have the correct keyring app installed for your distro. The remaining commands will clone `mkosi` and Liberated `systemd`.
2. Use `test.sh` to run the tests. Monitor the terminal and check to see if the VM launches correctly.

## How this works
Liberated `systemd` uses git patches to patch out surveillance enablement in base `systemd`. The patch used can be found in `main.patch`. If you want to know *exactly* what is removed in systemd code, this file will tell you all of that.

Note that README changes are not included in that patch. The Liberated `systemd` readme is maintained separately, because:
1. The patch is meant to be minimal, and (mostly) constant. It should not have to change every time I find a typo in the readme, or add a sentence.
2. it is not a code component, and therefore is not needed for the patch to work
3. I have no reason to expect hard-to-merge changes arising due in a README file

## TODO list
There are several tasks I am currently working on to streamline the process of updating and testing Liberated `systemd`. If you want to help the project, this would be a great place to step in!

Here's what I still need to do:
1. automate everything from test -> commit -> push. Right now, testing is 99% automatic -- but I have to check the VM at the end and verify it is up. I'd like to get this to instead return 1 (passed) or 0 (failed) with an error message. Once that's done, it's a simple bash script to automate commits and pushes.
2. automate merging new code from base `systemd`. The idea here is to detect whenever a commit is made to `systemd/main`, pull the data, and auto-merge it. After that, this could be connected to the test -> commit -> push pipeline to functionally automate updating Liberated `systemd`.

A note on the second part -- age verification in `systemd` was / is very much a tack-on, not a core part of the code. I expect that almost all updates to `systemd` won't conflict with the changes made to remove age verification, which means that in most cases this should be able to be done automatically. In reality, it will be necessary to implement human oversight before a push -- just in case *other* forms of surveillance are implemented, or if the manner in which age verification support is written in base `systemd` changes.

## Contributing and Licensing
This repo is made available under the same license as base `systemd` and Liberated `systemd`: the GNU General Public License v2. All code contributions must be made available under the same license.

Please note that PRs including AI-generated code, be it correct or incorrect, will be rejected until re-written by a human.

## Liberated `systemd` source code
You can find Liberated `systemd` here:
- github - https://github.com/Jeffrey-Sardina/systemd
- codeberg (mirror) - https://codeberg.org/Jeffrey-Sardina/systemd
- gitea (mirror) - https://gitea.com/Jeffrey-Sardina/systemd
