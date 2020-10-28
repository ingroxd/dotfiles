#!/bin/bash

[ -z "${PS1-}" ] && return

export EDITOR='vim'
if [ -n "${TMUX}" ]; then
  export TERM='screen-256color'
else
  export TERM='xterm-256color'
fi
export LIBVIRT_DEFAULT_URI='qemu:///system'

export CLICOLOR=true

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%Y%m%dT%H%M%S%z '
shopt -s histappend

shopt -s checkwinsize

if [ -d ~/.bash ]; then
  if [ -f ~/.bash/ps1.sh ]; then
    . ~/.bash/ps1.sh
  fi
  if [ -f ~/.bash/path.sh ]; then
    . ~/.bash/path.sh
  fi
  if [ -f ~/.bash/aliases.sh ]; then
    . ~/.bash/aliases.sh
  fi
fi

[ -f /etc/bash_completion ] && . /etc/bash_completion

