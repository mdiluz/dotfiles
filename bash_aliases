#!/bin/bash

# Open with xdg
if [ $( which xdg-open ) ]; then
alias open=xdg-open
fi

# git-svn commands
alias gitsvnup="git stash && git svn rebase && git stash pop && alert"
alias gitsvnpush="git stash && git svn dcommit && git stash pop && alert"

# pretty log
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# hard reset an svn working copy
alias svnhardreset='read -p "destroy all local changes?[y/N]" && [[ $REPLY =~ ^[yY] ]] && svn revert . -R && rm -rf $(awk -f <(echo "/^?/{print \$2}") <(svn status) ;)'

function gitsvnfind()
{
	hash=$(git svn find-rev r${1})
	git show $hash 
}

# make a git repo within a girectory 
alias creategit="git init && git add -A && git commit -m \"Initial commit\""

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Edit a file in qtcreator
alias qtedit="qtcreator -client"

# OSX - check an apps codesigning
alias checkcodesignosx="codesign -dvv --entitlements -"

# OSX - quick fixes
alias flushdnsosx="dscacheutil -flushcache"

# Source in feral specific aliases if they exist
test -e ~/.feral_aliases && source ~/.feral_aliases
