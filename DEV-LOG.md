# Liberated `systemd` -- dev log

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
