#!/bin/bash

[ -z "${PS1-}" ] && return

export EDITOR='vim'
export TERM='xterm-256color'
export LIBVIRT_DEFAULT_URI='qemu:///system'

export CLICOLOR=true

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%Y%m%dT%H%M%S%z '
shopt -s histappend

shopt -s checkwinsize

[ -f ~/.bash_ps1 ] && . ~/.bash_ps1

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

if [ -d ~/.rbenv/bin ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi

[ -f /etc/bash_completion ] && . /etc/bash_completion

