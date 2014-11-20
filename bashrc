#!/bin/bash

# ======================================================================================================================
# If not running interactively, don't do anything
test -z "$PS1" && return

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Colours
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Set my editor to nano
export EDITOR=nano

# Add custom bin
PATH="$HOME/bin:$PATH"

# Add our custom dotfiles
PATH="$DOTFILESDIR/bin:$PATH"
PERL5LIB="$DOTFILESDIR/perl:$PERL5LIB"

# ======================================================================================================================
# Pull in feral specific stuff
test -e ~/.feralrc && source ~/.feralrc

# ======================================================================================================================
# Set the PS1

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Pull in my aliases
test -f $DOTFILESDIR/bash_aliases && source $DOTFILESDIR/bash_aliases

# If we have colour support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

# Limit number of directories to 3
PROMPT_DIRTRIM=3

# Colour my prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt

# ======================================================================================================================

# enable programmable completion features by default
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ======================================================================================================================
# Label if I'm running from within the steam runtime

if [ $( echo $PATH | grep "steam-runtime" ) ]; then
    PS1="[STEAMSHELL] $PS1"
fi
