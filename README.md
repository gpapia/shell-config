# shell-config

This repo contains my (Gianluigi Papia) shell configuration supposed to be
shell agnostic but only tested with `bash`.

## Coding Conventions

### Use `$HOME` instead of `~`

The tilde (`~`) is part of a shell expansion. The `$HOME` variable is
exportable and can be used independent of a specific shell.

## Bash

### Invocation

When `bash` is invoked as an interactive login shell, or as a non-interactive
shell with the `--login` option, it first reads and executes commands from the
file `/etc/profile`, if that file exists. After reading that file, it looks for
`~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and reads
and executes commands from the first one that exists and is readable. The
`--noprofile` option may be used when the shell is started to inhibit this
behavior.

When an interactive shell that is not a login shell is started, `bash` reads
and executes commands from `/etc/bash.bashrc` and `~/.bashrc`, if these files
exist. This may be inhibited by using the `--norc` option. The `--rcfile` file
option will force bash to read and execute commands from file instead of
`/etc/bash.bashrc` and `~/.bashrc`.

If `bash` is invoked with the name `sh`, it tries to mimic the startup behavior
of historical versions of `sh` as closely as possible, while conforming to the
POSIX standard as well. When invoked as an interactive login shell or a
non-interactive shell with the `--login` option, it first attempts to read and
execute commands from `/etc/profile` and `~/.profile`, in that order. The
`--noprofile` option may be used to inhibit this behavior. When invoked as an
interactive shell with the name `sh`, bash looks for the variable `ENV`,
expands its value if it is  defined, and uses the expanded value as the name of
a file to read and execute. Since a shell invoked as `sh` does not attempt to
read and execute commands from any other startup files, the `--rcfile` option
has no effect. When invoked as `sh`, `bash` enters posix mode after the startup
files are read.
