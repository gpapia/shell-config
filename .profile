#########################
# Profile Configuration #
#########################
# `~/.profile` sources application settings.

# Bash
# ====
# When `bash` is invoked as an interactive login shell, or as a non-interactive
# shell with the `--login` option, `~/.bashrc` is not read and executed.
# So force `bash` to read and execute `~/.bashrc`.
#
# Note: the tilde (`~`) is part of a shell expansion. The `$HOME` variable is
#       exportable and can be used independent of a specific shell.
if [ -n "${BASH_VERSION}" ]
then
    if [ -f "${HOME}/.bashrc" ]
    then
        . "${HOME}/.bashrc"
    fi
fi
