################
# Bash Profile #
################
#
# `~/.bash_profile` sources application settings specific to `bash`.

# Source `~/.profile` and `~/.bashrc` even when `bash` is invoked as an
# interactive login shell, or as a non-interactive shell with the `--login`
# option.
test -f "${HOME}/.profile" -a -r "${HOME}/.profile" && . "${HOME}/.profile"
test -f "${HOME}/.bashrc" -a -r "${HOME}/.bashrc" && . "${HOME}/.bashrc"
