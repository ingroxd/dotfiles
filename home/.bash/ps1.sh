[ -f ~/.bash/font.sh ] && . ~/.bash/font.sh

ps1__chroot() {
  local color="${PS1_FMAGENTA}"
  local data''; data="$(cat /etc/debian_chroot 2>/dev/null)"
  if [ -n "${data}" ]; then
    data="[${data}]"
  fi
  export chroot="${color}${data}${PS1_END}"
}

ps1__venv() {
  local color="${PS1_FYELLOW}"
  local data="${VIRTUAL_ENV-}"
  if [ -n "${data}" ]; then
    data="(${_data##*/})"
  fi
  export venv="${color}${data}${PS1_END}"
}

ps1__user() {
  local color="${PS1_FGREEN}"
  local data='\u'
  if [ $((UID)) -eq 0 ]; then
    color="${PS1_FRED}"
  elif [ $((UID)) -lt 1000 ]; then
    color="${PS1_FYELLOW}"
  fi
  export user="${color}${data}${PS1_END}"
}

ps1__host() {
  local color="${PS1_FCYAN}"
  local data='\h'
  export host="${color}${data}${PS1_END}"
}

ps1__git() {
  local color="${PS1_FGREEN}"
  local data='' data="$(
    git branch --no-color 2>/dev/null \
    | grep -e '^\*' \
    | cut -d ' ' -f 2
  )"
  if [ -n "${data}" ]; then
    if [ -n "$(git diff --stat 2>/dev/null)" ]; then
      color="${PS1_FYELLOW}"
      data="${PS1_FRED}!${color}${data}"
    fi
    data="[${data}]"
  fi
  export git="${color}${data}${PS1_END}"
}

ps1__dir() {
  local color="${PS1_FBLUE}"
  local data='\w'
  export dir="${color}${data}${ps1_end}"
}

ps1__errcode() {
  local color="${PS1_FGREEN}"
  local data="${1}"; shift
  data="$(printf '%.3i' $((data)) )"

  if [ "${data}" -ne 0 ]; then
    color="${PS1_FRED}"
  fi
  export errcode="${color}${data}${PS1_END}"
}

ps1__prompt() {
  local data='$'
  if [ $((UID)) -eq 0 ]; then
    data='#'
  fi
  export prompt="${data}${PS1_END} "
}

ps1() {
  # save error code
  local _errcode="${?}"

  ps1__chroot
  ps1__venv
  ps1__user
  ps1__host
  ps1__git
  ps1__dir
  ps1__errcode "${_errcode}"
  ps1__prompt

  # clean PS1
  PS1='\n\[\e[G\]'
  # line0
  PS1="${PS1}${chroot}${venv}${user}@${host}:${git}${dir}\n"
  # line1
  PS1="${PS1}${errcode}${prompt}"
}

__ps1__load() {
  export PROMPT_COMMAND=ps1
}

__ps1__load "${@}"

