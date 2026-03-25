# Liberated `systemd` -- testing and automation suite

This is where I manage all testing and automation related tasks for Liberated `systemd` (https://github.com/Jeffrey-Sardina/systemd). 

## The testing pipeline
Currently, this is nothing fancy. Once changes are made to the `systemd` fork, all tests in `test.sh` are run. These are the same CI tests base `systemd` requires for all pull requests (see: https://systemd.io/HACKING/). In short, this consists of creating a VM running `systemd` from the (new) source code, and verifying that it runs.

New pushes of Liberated `systemd` code are only made once tests pass.

## TODO list
There are several tasks I am currently working on to streamline the process of updating and testing Liberated `systemd`. If you want to help the project, this would be a great place to step in!

Here's what I still need to do:
1. automate everything from test -> commit -> push. Right now, testing is 99% automatic -- but I have to check the VM at the end and verify it is up. I'd like to get this to instead return 1 (passed) or 0 (failed) with an error message. Once that's done, it's a simple bash script to automate commits and pushes.
2. automate merging new code from base `systemd`. The idea here is to detect whenever a commit is made to `systemd/main`, pull the data, and auto-merge it. After that, this could be connected to the test -> commit -> push pipeline to functionally automate updating Liberated `systemd`.

A note on the second part -- age verification in `systemd` was / is very much a tack-on, not a core part of the code. I expect that almost all updates to `systemd` won't conflict with the changes made to remove age verification, which means that in most cases this should be able to be done automatically. In reality, it will be necessary to implement human oversight before a push -- just in case *other* forms of surveillance are implemented, or if the manner in which age verification support is written in base `systemd` changes.

## Contributing and Licensing
This repo is made available under the same license as base `systemd` and Liberated `systemd`: the GNU General Public License v2. All code contributions must be made available under the same license.

## Liberated `systemd` source code
You can find Liberated `systemd` here:
- github - https://github.com/Jeffrey-Sardina/systemd
- codeberg (mirror) - https://codeberg.org/Jeffrey-Sardina/systemd
- gitea (mirror) - https://gitea.com/Jeffrey-Sardina/systemd
