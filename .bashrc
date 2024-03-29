######################
# Bash Configuration #
######################
#
# `~/.bashrc` is the configuration file specific to `bash`.

# Source Common Bourne Shell Configuration
# ========================================
# `~/.shrc` file should be executed first by the shell.
test -f "${HOME}/.shrc" -a -r "${HOME}/.shrc" && . "${HOME}/.shrc"

# *********************************************
# STOP here if not running an interactive shell
# *********************************************
# Note: `$-` prints the current set of options in the current shell.
#       `i` is in the set if current shell is interactive.
case $- in
    *i*) ;;
    *) return;;
esac

# Conda
# =====
# The content below was copied & adapted from the output of
# `conda init --dry-run --verbose bash`.
if command -v conda > /dev/null
then
    __conda_setup="$('/opt/conda/condabin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
        # Deactivate the base environment that conda installed by default.
        # This gives priority to system Python tools/libraries unless a conda
        # environment is explicitly activated.
        conda deactivate
    fi
    unset __conda_setup

    # Make sure conda environment gets automatically activated in Pycharm and not in Windows terminal.
    if [ -z ${WT_SESSION+x} ] && [ -f environment.yml ] && conda env list | grep -qE "^$(basename $PWD) "
    then
        # if not in windows terminal AND
        # environment.yml exists AND
        # corresponding conda environment exists
        conda activate $(basename $PWD)
    fi
fi

# Aliases
# =======
# Define some aliases.
if [ -f "${HOME}/.bash_aliases" ]
then
    test -r "${HOME}/.bash_aliases" && . "${HOME}/.bash_aliases"
fi

# History
# =======
# When the `-o` history option to the set builtin is enabled, the shell provides
# access to the command history, the list of commands previously typed. The
# value of the `HISTSIZE` variable is used as the number of commands to save in
# a history list. The text of the last `HISTSIZE` commands is saved.
#
# On startup, the history is initialized from the file named by the variable
# `HISTFILE` (default `~/.bash_history`). The file named by the value of
# `HISTFILE` is truncated, if necessary, to contain no more than the number of
# lines specified by the value of `HISTFILESIZE`. If `HISTFILESIZE` is unset, or
# set to null, a non-numeric value, or a numeric value less than zero, the
# history file is not truncated. When the history file is read, lines  beginning
# with the history comment character followed immediately by a digit are
# interpreted as timestamps for the following history line. These timestamps are
# optionally displayed depending on the value of the `HISTTIMEFORMAT` variable.
# When a shell with history enabled exits, the last `$HISTSIZE` lines are copied
# from the history list to `$HISTFILE`. If the `histappend` shell option is
# enabled the lines are appended to the history file, otherwise the history file
# is overwritten. If `HISTFILE` is unset, or if the history file is unwritable,
# the history is not saved. If the `HISTTIMEFORMAT` variable is set, time stamps
# are written to the history file, marked with the history comment character, so
# they may be preserved across shell sessions. This uses the history comment
# character to distinguish  timestamps from other history lines. After saving
# the history, the history file is truncated to contain no more than
# `HISTFILESIZE` lines. If `HISTFILESIZE` is unset, or set to null, a
# non-numeric value, or a numeric value less than zero, the history file is not
# truncated.
#
# The shell allows control over which commands are saved on the history list.
# The `HISTCONTROL` and `HISTIGNORE` variables may be set to cause the shell
# to save only a subset of the commands entered. The `cmdhist` shell option,
# if enabled, causes the shell to attempt to save each line of a multi-line
# command in the same history entry, adding semicolons where necessary to
# preserve syntactic correctness. The `lithist` shell option causes the shell to
# save the command with embedded newlines instead of semicolons.

# HISTCONTROL
# A colon-separated list of values controlling how commands are saved on the
# history list. If the list of values includes `ignorespace`, lines which begin
# with a space character are not saved in the history list. A value of
# `ignoredups` causes lines matching the previous history entry to not be saved.
# A value of `ignoreboth` is shorthand for `ignorespace` and `ignoredups`.
# A value of `erasedups` causes all previous lines matching the current line to
# be removed from the history list before that line is saved. Any value not in
# the above list is ignored. If `HISTCONTROL` is unset, or does not include a
# valid value, all lines read by the shell parser are saved on the history list,
# subject to the value of `HISTIGNORE`. The second and subsequent lines of a
# multi-line compound command are not tested, and are added to the history
# regardless of the value of `HISTCONTROL`.
#
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# HISTSIZE
# The number of commands to remember in the command history. If the value is
# `0`, commands are not saved in the history list. Numeric values less than zero
# result in every command being saved on the history list (there is no limit).
# The shell sets the default value to 500 after reading any startup files.
HISTSIZE=100000

# HISTFILESIZE
# The maximum number of lines contained in the history file. When this variable
# is assigned a value, the history file is truncated, if necessary, to contain
# no more than that number of lines by removing the oldest entries. The history
# file is also truncated to this size after writing it when a shell exits.
# If the value is 0, the history file is truncated to zero size. Non-numeric
# values and numeric values less than zero inhibit truncation. The shell sets
# the default value to the value of `HISTSIZE` after reading any startup files.
HISTFILESIZE=20000000

# HISTIGNORE
# A colon-separated list of patterns used to decide which command lines should
# be saved on the history list. Each pattern is anchored at the beginning of the
# line and must match the complete line (no implicit `*' is appended). Each
# pattern is tested against the line after the checks specified by `HISTCONTROL`
# are applied. In addition to the normal shell pattern matching characters,
# `&`  matches the previous history line. `&` may be escaped using a backslash;
# the backslash is removed before attempting a match. The second and subsequent
# lines of a multi-line compound command are not tested, and are added to the
# history regardless of the value of `HISTIGNORE`. The pattern matching honors
# the setting of the `extglob` shell option.
HISTIGNORE="cd:cd -:ciao:exit:history:history :lrt:ls:pwd:rmh:rmspace:rmtt"

# histappend
# If set, the history list is appended to the file named by the value of the
# `HISTFILE` variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# Globstar
# ========
# The `*` matches any string, including the null string. When the `globstar`
# shell option is enabled, and `*` is used in a pathname expansion context,
# two adjacent `*`s used as a single pattern will match all files and zero
# or more directories and subdirectories. If followed by a `/`, two adjacent
# `*`s will match only directories and subdirectories.
#
# Set the pattern `**` used in a pathname expansion context that will match all
# files and zero or more directories and subdirectories. If the pattern is
# followed by a `/`, only directories and subdirectories match.
shopt -s globstar

# Checkwinsize
# ============
# If set, `bash` checks the window size after each external (non-builtin)
# command and, if necessary, updates the values of `LINES` and `COLUMNS`. This
# option is enabled by default, but just be sure.
#
# COLUMNS
# Used by the `select` compound command to determine the terminal width when
# printing selection lists. Automatically set if the `checkwinsize` option is
# enabled or in an interactive shell upon receipt of a `SIGWINCH`.
#
# LINES
# Used by the `select` compound command to determine the column length for
# printing selection lists. Automatically set if the `checkwinsize` option is
# enabled or in an interactive shell upon receipt of a `SIGWINCH`.

shopt -s checkwinsize

# Bash Completion
# ===============
# Don't use `bash_completion` if `bash` is run in posix mode (why?).
if ! shopt -oq posix
then
    if [ -f /usr/share/bash-completion/bash_completion ] && [ -r /usr/share/bash-completion/bash_completion ]
    then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ] && [ -r /etc/bash_completion ]
    then
      . /etc/bash_completion
    fi
fi

# pipx completion
# ===============
if command -v pipx > /dev/null
then
    eval "$(register-python-argcomplete3 pipx)"
fi

# TODO
# ====
# Old configuration coming from Ubuntu install.

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
