# Liberated `systemd` -- dev log

## April 21, 2026
Ran intosome failed builds whose origins are not yet clear to me. I'll keep working on this -- I have a hunch about the source. Expect an update in the next couple days, once I verify that Liberated systemd is correct.

## April 16, 2026
I have removed `test-auto.sh` from the repo, since I was not using it at all. There's definitely a better way to automate tests than what it does -- and in any case, `ref-commands.sh` is a much easier-to-read source of what commands are run in testing.

I have also removed `ref-release.sh` and plan to make releases through a simpler format -- download their release, apply the Liberated `systemd` patch to it, test it, and publish it. This way, there is much less room error, and the same end result of having no age verificaction enablement.

## April 14, 2026
I have renamed the fork repo on GitHub from `systemd` to `liberated-systemd` so that it will show in search results. **This does not require any action by any who use the fork, as all requests to the former URL still resolve.** The previous URL (https://github.com/Jeffrey-Sardina/systemd) remains fully functional for pulling, cloning, and accessing via the web. Since Gitea and Codeberg repos show in search results, these have not been renamed.

I have created a new project (https://github.com/users/Jeffrey-Sardina/projects/1) for implementing named versions in Liberated systemd. This is intended to be retrospective for `systemd-stable v260.1`, and to apply to all future releases.
