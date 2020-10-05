alias ls="ls --color=auto" 
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color"

alias xclipi='xclip -selection clipbloard -i'
alias xclipo='xclip -selection clipbloard -o'

if ! command -v nc >/dev/null; then
  alias nc='busybox nc'
fi

