#!/bin/bash

ps1() {
  # save error code
  local errcode="${?}"

  # endl
  local endl='\n'
  # chroot
  local chroot=''; chroot="$(cat /etc/debian_chroot 2>/dev/null)"
  [ -n "${chroot-}" ] && chroot="${ps1_chroot}[${chroot}]${ps1_end}"
  # venv
  local venv="${VIRTUAL_ENV-}"
  [ -n "${venv-}" ] && venv="${ps1_venv}(${venv##*/})${ps1_end}"
  # user
  if [ $((UID)) -eq 0 ]; then
    export ps1_user="${ps1_user_err}"
  elif [ $((UID)) -lt 1000 ]; then
    export ps1_user="${ps1_user_warn}"
  else
    export ps1_user="${ps1_user_ok}"
  fi
  local user='\u'
  user="${ps1_user}${user}${ps1_end}"
  # at
  local at='@'
  at="${ps1_hud}${at}${ps1_end}"
  # host
  local host='\h'
  host="${ps1_host}${host}${ps1_end}"
  # in
  local in=':'
  in="${ps1_hud}${in}${ps1_end}"
  # git
  local git=''; git="$(git branch --no-color 2>/dev/null | grep -e '^\*' | cut -d ' ' -f 2)"
  if [ -n "${git-}" ]; then
    if [ -n "$(git diff 2>/dev/null)" ]; then
      local ps1_git="${ps1_git_warn}"
      git="${ps1_end}${ps1_git_err}!${ps1_git}${git}"
    fi
    git="${ps1_git}[${git}]${ps1_end}"
  fi
  # dir
  local dir='\w'
  dir="${ps1_dir}${dir}${ps1_end}"
  # errcode
  if [ $((errcode)) -ne 0 ]; then
    export ps1_errcode="${ps1_errcode_err}"
  else
    export ps1_errcode="${ps1_errcode_ok}"
  fi
  errcode="${ps1_errcode}$(printf '%.3i' $((errcode)))${ps1_end}"
  # prompt
  local prompt='$'
  [ $((UID)) -eq 0 ] && prompt='#'
  prompt="${ps1_prompt}${prompt}${ps1_end} "

  # clean PS1
  PS1='\n\[\e[G\]'
  # line0
  PS1="${PS1}${chroot}${venv}${user}${at}${host}${in}${git}${dir}${endl}"
  # line1
  PS1="${PS1}${errcode}${prompt}"
}

ps1__load() {
  export PROMPT_COMMAND=ps1
}

ps1__load "${@}"

