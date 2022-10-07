######################
# Bash Configuration #
######################
#
# `~/.bashrc` is the configuration file specific to `bash`.

# Source Common Shell Configuration
# =================================
# `~/.shrc` file should be executed first by the shell.
#
# Note: the tilde (`~`) is part of a shell expansion. The `$HOME` variable is
#       exportable and can be used independent of a specific shell.
if [ -f "${HOME}/.shrc" ]
then
    . "${HOME}/.shrc"
fi

# Configuration for interactive shell
# ===================================
# If not running interactively, don't do anything.
# Note: `$-` prints the current set of options in the current shell.
#       `i` is in the set if current shell is interactive.
case $- in
    *i*) ;;
    *) return;;
esac

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
HISTSIZE=1000

# HISTFILESIZE
# The maximum number of lines contained in the history file. When this variable
# is assigned a value, the history file is truncated, if necessary, to contain
# no more than that number of lines by removing the oldest entries. The history
# file is also truncated to this size after writing it when a shell exits.
# If the value is 0, the history file is truncated to zero size. Non-numeric
# values and numeric values less than zero inhibit truncation. The shell sets
# the default value to the value of `HISTSIZE` after reading any startup files.
HISTFILESIZE=100000

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

# TODO
# ====
# Old configuration coming from Ubuntu install.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
