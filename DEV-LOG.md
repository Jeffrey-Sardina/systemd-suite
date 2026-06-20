# Liberated `systemd` -- dev log

## June 19,2026
The release has been built and tested. Lots more docs in. I'm going to install this on my own computer before making a final push.

## June 19,2026
I see that systemd 261 has been released. I'm activaly working on a Liberated version -- hopefully today. I'll update again when that's published.
 
## June 13, 2026
I apologise for the delay here. It tujens out that the bug is always in the last place you look... In this case, a cache I *thought* I was clearing was not getting cleared, and the `systemd` build process was throwing errors because it expected parts of it to be empty. The good news is, it was just caching -- not an issue with (Liberated) `systemd` code. We now have successful builds, and 0 test failures. I *also* had some KVM issues, but the Arch Wiki saved me there. I love that wiki.

I've added notes on what went wrong to the reference commands. I'll keep doing that, to make this easy for others to run and test as possible.

Novaer!

## June 9, 2026
I've beenrunninginto build errors again -- will update more once I have run more tests.

## June 1, 2026
Just pushed another update. Starting to check in on how to rebuild the patch file for this, since more code changes have been necessary to keep `systemd` free of age surveillance (in short: the command-line options for saving user birthdays were updated, and so I had to remove thema gain from a later commit).

All tests continue to pass, and no build issues are coming up.

Novaer, mellyn!

## May 31,2026
Finally gotanupdate in -- had to change the merge process a bittodo so. All tests passing. Systemd 260.2 has been released, butdoes not inlcude sureveillance enablement. As such, I am not mnaking a Liberated version of it, as there are no changes to make. 

## May 24, 2026
Unfortunately, base `systemd` build errors persist. This is not something that Liberated systemd can fix, as it does not relate to surveillance infrastructure. I'll keep checking (and updating here) every few days. This has happened often before -- upstream usually fixes the issueswithina weekor so. But since upstream is currentlyunstable andwill not produce usableimages, I don't feel comfortable merging the code and potentially cuasing broken installs. PID1 is not a place for instability.

## May 19, 2026
Once again encountering build failures on Arch, so I'm not doing a full update yet. It's still well under a week since the last update, so Liberated `systemd` remains on schedule. I also see that upstrteam there are *tons* of changes getting ready for v261.

Some of the new changes are going to require updating the `main.patch` file -- but aside from that, everything is ready to produce a Liberated release of v261. My target for that, as with all updates, is for the Liberated version to be released within 1 week of upstream publishing v261. 

### Appeal for help
At the time of doing so I *also* plan to raise a PR against upstream `systemd`, as a symbolic move to object to surveillance enablement. I doubt it will be accepted, but if ever there was a time to do so, it's when eyes will already be on this project because of the v261 release.

If you are reading this, I would appreciate if you could help spread the word once Liberated `systemd` v261 is released. I understand this is a very divisive topic -- but please also remember that our actions will carry more weight if we make our point politely as well as firmly.

I'm not sure of the exact timeline yet.

### Appeal for testers
If you want to help test v261 of Liberated `systemd`, please feel free to reach out. I'd love if we could assemble a list of officially tested OSes. What this involves is basically:
1. Install a VM of an OS of choice (I currently have my Ubuntu and Arch machines on Liberated `systemd`. But any OS that runs `systemd` is welcome -- and replicates are always great!)
2. Install Liberated `systemd` on it
3. Run unit tests
4. Make sure the VM works and is stable

### Note to distro maintainers
If you maintain a Linux distro and are considering moving to Liberated `systemd`, please feel free to reach out. I'd love to answer any questions you have about this project.

### Final note
Quick shout-out to all the Linux distros that (for years) have been saying "systemd is getting too centralized / universal / corporate, this could be an issue". You's were right. And even though (perhaps especially because) I run a `systemd` fork, I have huge respect for distros that go without it.

## May 15, 2026
Upstream `systemd` has hit some failed tests again on `main`. Specifically, the failures are:
```
Summary of Failures:

1471/1473 dist - systemd:check-version-ukify                                       FAIL             0.14s   exit status 2
1472/1473 dist - systemd:check-help-ukify                                          FAIL             0.25s   exit status 2

Ok:                1448
Fail:              2   
Skipped:           23  
```

These errors, as epected, as therefore also present in Liberated `systemd`. However, the VM still boots and can run commands -- both for both base and Liberated `systemd`. As such, I have still pushed these updates to Liberated `systemd`.

## May 14, 2026
The failed test condition has been fixed upstream, meaning that base and Liberated systemd both now pass all tests.

## May 11, 2026
Upstream changes resolved the build issues. All has now been tested & pushed bringing Liberated `systemd` up to date.

## May 9, 2026
I've done somemore digging on this -- I'm still unsure of the origin of this issue. I do know, however, that it is not present in the version of Liberated systemd currently pushed. I am going to try to do a "partial upgrade" up to the commit in which the error  was introduced. At least in this case, we'll get some updates -- and it will help me start to determine which commit introduuced this issue. If it comes to it, I'll see about raising a PR against the upstream repo to fix it.

## May 6, 2026
Running into build errors from upstream -- VM images built with the latest systemd (liberated or base) fail with the same error. As this would almost certainly cause user installs of Liberated systemd to crash, I will not be updating Liberated systemd until this is fixed. I'll update in a few days if this error persists.

## April 30, 2026
The test failure is not resolving upstream -- this is not the first time that failures have lasted nearly week upstream. As such, I am going to change my push criteria to the following:
1. the VM `mkosi` running Liberated `systemd` from source runs
2. Liberated `systemd` is *at least as stable as* base `systemd`.

This means that if base `systemd` contains failed unit tests that also fail in Liberated `systemd`, Liberated systemd will still track upstream changes. This change was made necessary by the fact that base `systemd` often has long-standing (for a week or more) failed tests. If Liberated `systemd` did not track changes during this time, it would become far out of date.

So basically: if you install Liberated `systemd` from source, you'll get something *as stable as* installing base `systemd` from source.

## April 27, 2026
Ran into a test failure on the latest commits, although VMs built with them still run. I have replicated this error in base `systemd` as well -- it's not caused by Liberated `systemd`. As always, no changes will be merged until all tests pass. For now, I'm going to wait for a fix from upstream.

Failed test output:
```
stderr:
/* test_readlink_and_make_absolute */
/* test_get_files_in_directory */
/* test_var_tmp */
/* test_dot_or_dot_dot */
/* test_access_fd */
/* test_touch_file */
/* test_unlinkat_deallocate */
/* test_fsync_directory_of_file */
/* test_rename_noreplace */
/* test_chmod_and_chown */
test-fs-util: not running as root or in userns with single user, skipping tests.
/* test_conservative_rename */
/* test_rmdir_parents */
/* test_parse_cifs_service */
/* test_open_mkdir_at */
/* test_openat_report_new */
/* test_xopenat_full */
/* test_xopenat_regular */
/* test_xopenat_socket */
/* test_xopenat_trigger_automount */
/* test_xopenat_auto_rw_ro */
Assertion '(fl & O_ACCMODE) == O_RDONLY' failed at src/test/test-fs-util.c:866, function test_xopenat_auto_rw_ro(). Aborting.
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

 972/1472 test - systemd:test-procfs-util                                                    SKIP             0.12s   exit status 77
 981/1472 test - systemd:test-sd-hwdb                                                        SKIP             0.14s   exit status 77
1040/1472 tmpfiles - systemd:test-systemd-tmpfiles                                           SKIP             0.09s   exit status 77
1047/1472 dist - systemd:check-version-history                                               SKIP             0.04s   exit status 77
1048/1472 udev - systemd:test-udev                                                           SKIP             0.10s   exit status 77
1050/1472 dist - systemd:parse-hwdb                                                          SKIP             0.08s   exit status 77
1051/1472 dist - systemd:dbus-docs-fresh                                                     SKIP             0.08s   exit status 77

Summary of Failures:

 906/1472 test - systemd:test-fs-util                                              FAIL             0.22s   killed by signal 6 SIGABRT

Ok:                1450
Fail:              1   
Skipped:           21  
```

## April 23, 2026
The error was resolved by a later version of systemd. All tests and BM build now pass, so the code has been updated.

## April 21, 2026
Ran into some failed builds whose origins are not yet clear to me. I'll keep working on this -- I have a hunch about the source. Expect an update in the next couple days, once I verify that Liberated `systemd` is correct.

UPDATE: I've tracked this to an error in the mkosi build process that occurs with base `systemd` as well. Still searching for root cause, which could be in any number of places (and not necessarily in `systemd`). For obvious reasons, I won't do a push until I can verify that the code is working.

## April 16, 2026
I have removed `test-auto.sh` from the repo, since I was not using it at all. There's definitely a better way to automate tests than what it does -- and in any case, `ref-commands.sh` is a much easier-to-read source of what commands are run in testing.

I have also removed `ref-release.sh` and plan to make releases through a simpler format -- download their release, apply the Liberated `systemd` patch to it, test it, and publish it. This way, there is much less room error, and the same end result of having no age verificaction enablement.

## April 14, 2026
I have renamed the fork repo on GitHub from `systemd` to `liberated-systemd` so that it will show in search results. **This does not require any action by any who use the fork, as all requests to the former URL still resolve.** The previous URL (https://github.com/Jeffrey-Sardina/systemd) remains fully functional for pulling, cloning, and accessing via the web. Since Gitea and Codeberg repos show in search results, these have not been renamed.

I have created a new project (https://github.com/users/Jeffrey-Sardina/projects/1) for implementing named versions in Liberated systemd. This is intended to be retrospective for `systemd-stable v260.1`, and to apply to all future releases.
