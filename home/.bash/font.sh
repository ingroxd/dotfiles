"${__LIB_FONT__LOADED-false}" && return    # If loaded, do nothing
"${__LIB_FONT__LOADING-false}" && exit 70  # If loading, something is wrong

__font__enable() {
  export PS1_BOLD='\033[1m'       # "$(tput bold)"
  export PS1_DARK='\033[2m'       # "$(tput smul)"
  export PS1_ITALIC='\033[3m'
  export PS1_ULINE='\033[4m'
  export PS1_BLINK='\033[5m'
  export PS1_REVERSE='\033[7m'
  export PS1_HIDE='\033[8m'
  export PS1_STRIKE='\033[9m'
  export PS1_END='\033[0m'       # "$(tput sgr0)"

  export PS1_FBLACK='\033[30m'     # "$(tput setaf 0)"
  export PS1_FRED='\033[31m'       # "$(tput setaf 1)"
  export PS1_FGREEN='\033[32m'     # "$(tput setaf 2)"
  export PS1_FYELLOW='\033[33m'    # "$(tput setaf 3)"
  export PS1_FBLUE='\033[34m'      # "$(tput setaf 4)"
  export PS1_FMAGENTA='\033[35m'   # "$(tput setaf 5)"
  export PS1_FCYAN='\033[36m'      # "$(tput setaf 6)"
  export PS1_FWHITE='\033[38m'     # "$(tput setaf 7)"

  export PS1_BBLACK='\033[40m'    # "$(tput setab 0)"
  export PS1_BRED='\033[41m'      # "$(tput setab 1)"
  export PS1_BGREEN='\033[42m'    # "$(tput setab 2)"
  export PS1_BYELLOW='\033[43m'   # "$(tput setab 3)"
  export PS1_BBLUE='\033[44m'     # "$(tput setab 4)"
  export PS1_BMAGENTA='\033[45m'  # "$(tput setab 5)"
  export PS1_BCYAN='\033[46m'     # "$(tput setab 6)"
  export PS1_BWHITE='\033[47m'    # "$(tput setab 7)"

  if [ -x /usr/bin/dircolors ]; then
    if [ -x ~/.dircolors ]; then
      eval "$(dircolors -b ~/.dircolors)"
    else
      eval "$(dircolors -b)"
    fi
  fi

  export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
}

funct() {
  export ps1_std="${ps1_end}"
  export ps1_ok="${ps1_green}"
  export ps1_warn="${ps1_yellow}"
  export ps1_err="${ps1_red}"

  export ps1_hud="${ps1_std}"

  export ps1_chroot="${ps1_magenta}"
  export ps1_venv="${ps1_yellow}"

  export ps1_user_ok="${ps1_ok}"
  export ps1_user_warn="${ps1_warn}"
  export ps1_user_err="${ps1_err}"
  export ps1_user="${ps1_user_ok}"

  export ps1_host="${ps1_cyan}"

  export ps1_git_ok="${ps1_ok}"
  export ps1_git_warn="${ps1_warn}"
  export ps1_git_err="${ps1_err}"
  export ps1_git="${ps1_git_ok}"

  export ps1_dir="${ps1_blue}"

  export ps1_errcode_ok="${ps1_ok}"
  export ps1_errcode_err="${ps1_err}"
  export ps1_errcode="${ps1_errcode_ok}"

  export ps1_prompt_ok="${ps1_std}"
  export ps1_prompt_err="${ps1_err}"
  export ps1_prompt="${ps1_prompt_ok}"

}

__font__load() {
  __font_enable
}

__font__load "${@}"
export __LIB_FONT__LOADING=false
export __LIB_FONT__LOADED=true

