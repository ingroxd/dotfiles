alias ls="ls --color=auto" 
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

if command -v xclip >/dev/null; then
  alias xclipi='xclip -selection clipbloard -i'
  alias xclipo='xclip -selection clipbloard -o'
fi

if ! command -v nc >/dev/null; then
  alias nc='busybox nc'
fi

