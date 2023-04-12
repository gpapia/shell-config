################################
# Bash Shell Alias Definitions #
################################
#
# `~./bash_aliases` defines usefully aliases for `bash`.

# Source common Bourne shell aliases.
if [ -f "${HOME}/.sh_aliases" ]
then
    test -r "${HOME}/.sh_aliases" && . "${HOME}/.sh_aliases"
fi
