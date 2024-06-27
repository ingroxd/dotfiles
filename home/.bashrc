#!/bin/bash

[ -z "${PS1-}" ] && return

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%Y%m%dT%H%M%S%z '
shopt -s histappend

if [ -n "${TMUX}" ]; then
  export TERM='screen-256color'
else
  export TERM='xterm-256color'
fi

export CLICOLOR=true

if [ -x /usr/bin/dircolors ]; then
  if [ -x ~/.dircolors ]; then
    eval "$(/usr/bin/dircolors -b ~/.dircolors)"
  else
    eval "$(/usr/bin/dircolors -b)"
  fi
fi

export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

export PS1__FONT_BOLD='\[\033[1m\]'         # "$(tput bold)"
export PS1__FONT_DARK='\[\033[2m\]'         # "$(tput smul)"
export PS1__FONT_ITALIC='\[\033[3m\]'
export PS1__FONT_ULINE='\[\033[4m\]'
export PS1__FONT_BLINK='\[\033[5m\]'
export PS1__FONT_REVERSE='\[\033[7m\]'
export PS1__FONT_HIDE='\[\033[8m\]'
export PS1__FONT_STRIKE='\[\033[9m\]'
export PS1__FONT_END='\[\033[0m\]'          # "$(tput sgr0)"

export PS1__FONT_FG_BLACK='\[\033[30m\]'    # "$(tput setaf 0)"
export PS1__FONT_FG_RED='\[\033[31m\]'      # "$(tput setaf 1)"
export PS1__FONT_FG_GREEN='\[\033[32m\]'    # "$(tput setaf 2)"
export PS1__FONT_FG_YELLOW='\[\033[33m\]'   # "$(tput setaf 3)"
export PS1__FONT_FG_BLUE='\[\033[34m\]'     # "$(tput setaf 4)"
export PS1__FONT_FG_MAGENTA='\[\033[35m\]'  # "$(tput setaf 5)"
export PS1__FONT_FG_CYAN='\[\033[36m\]'     # "$(tput setaf 6)"
export PS1__FONT_FG_WHITE='\[\033[38m\]'    # "$(tput setaf 7)"

export PS1__FONT_BG_BLACK='\[\033[40m\]'    # "$(tput setab 0)"
export PS1__FONT_BG_RED='\[\033[41m\]'      # "$(tput setab 1)"
export PS1__FONT_BG_GREEN='\[\033[42m\]'    # "$(tput setab 2)"
export PS1__FONT_BG_YELLOW='\[\033[43m\]'   # "$(tput setab 3)"
export PS1__FONT_BG_BLUE='\[\033[44m\]'     # "$(tput setab 4)"
export PS1__FONT_BG_MAGENTA='\[\033[45m\]'  # "$(tput setab 5)"
export PS1__FONT_BG_CYAN='\[\033[46m\]'     # "$(tput setab 6)"
export PS1__FONT_BG_WHITE='\[\033[47m\]'    # "$(tput setab 7)"

ps1__chroot() {
  local color="${PS1__FONT_FG_MAGENTA}"
  local data=''; data="$(cat /etc/debian_chroot 2>/dev/null)"

  if [ -n "${data}" ]; then
    data="[${data}]"
  fi

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__venv() {
  local color="${PS1__FONT_FG_YELLOW}"
  local data="${VIRTUAL_ENV}"

  if [ -n "${data}" ]; then
    data="(${data##*/})"
  fi

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__user() {
  local color
  local data='\u'

  if [ $((UID)) -ge 1000 ]; then
    color="${PS1__FONT_FG_GREEN}"
  else
    if [ $((UID)) -eq 0 ]; then
      color="${PS1__FONT_FG_RED}"
    else
      color="${PS1__FONT_FG_YELLOW}"
    fi
  fi

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__host() {
  local color="${PS1__FONT_FG_CYAN}"
  local data='\h'

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__git() {
  local color
  local data=''; data="$(
    git branch --no-color 2>/dev/null \
      | grep -e '^\*' \
      | cut -d ' ' -f 2
  )"

  if [ -n "${data}" ]; then
    if [ -z "$(git diff --stat 2>/dev/null)" ]; then
      color="${PS1__FONT_FG_GREEN}"
    else
      color="${PS1__FONT_FG_RED}"
      data="!${PS1__FONT_FG_YELLOW}${data}"
    fi
    data="[${data}]"
  fi

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__dir() {
  local color="${PS1__FONT_FG_BLUE}"
  local data='\w'

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__errcode() {
  local color
  local data="${1}"; shift

  data="$(printf '%.3i' $((data)))"

  if [ "${data}" -eq 0 ]; then
    color="${PS1__FONT_FG_GREEN}"
  else
    color="${PS1__FONT_FG_RED}"
  fi

  printf '%s%s%s' ${color}${data}${PS1__FONT_END}
}

ps1__prompt() {
  local color="${PS1__FONT_END}"
  local data

  if [ $((UID)) -eq 0 ]; then
    data='#'
  else
    data='$'
  fi

  printf '%s%s%s' "${color}${data}${PS1__FONT_END}"
}

ps1() {
  # save error code
  local errcode="${?}"

  # clean $PS1
  PS1='\n\[\e[G\]'

  # chroot + venv
  PS1="${PS1}$(ps1__chroot)$(ps1__venv)"
  # user @ host
  PS1="${PS1}$(ps1__user)@$(ps1__host)"
  # git + dir
  PS1="${PS1}:$(ps1__git)$(ps1__dir)"
  # errcode + prompt (newline)
  PS1="${PS1}\n$(ps1__errcode "${errcode}")$(ps1__prompt) "
}

export PROMPT_COMMAND=ps1

shopt -s checkwinsize

if [ -f ~/.bash_aliases.sh ]; then
  . ~/.bash_aliases.sh
fi

export EDITOR='vim'

export LIBVIRT_DEFAULT_URI='qemu:///system'

if command -v rbenv >/dev/null && [ -d ~/.rbenv/bin ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi

[ -f /etc/bash_completion ] && . /etc/bash_completion
