################
# Bash Profile #
################
#
# `~/.bash_profile` sources application settings specific to `bash`.
#
# When `bash` is invoked as an interactive login shell, or as a non-interactive
# shell with the `--login` option, it first reads and executes commands from the
# file `/etc/profile`, if that file exists. After reading that file, it looks
# for `~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and
# reads and executes commands from the first one that exists and is readable.
# The `--noprofile` option may be used when the shell is started to inhibit this
# behavior.

# Note: the tilde (`~`) is part of a shell expansion. The `$HOME` variable is
#       exportable and can be used independent of a specific shell.

# Source `~/.profile` and `~/.bashrc` even when `bash` is invoked as an
# interactive login shell, or as a non-interactive shell with the `--login`
# option.
test -f "${HOME}/.profile" && test -r "${HOME}/.profile" && . "${HOME}/.profile"
test -f "${HOME}/.bashrc" && test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc"
