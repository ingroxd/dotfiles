alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

if ! command -v dos2unix >/dev/null; then
  alias dos2unix='sed -i -e s/\r$//'
fi

if ! command -v unix2dos >/dev/null; then
  alias unix2dos='sed -i -e s/$/\r/'
fi

if command -v xclip >/dev/null; then
  alias xclip-in='xclip -selection clipbloard -i'
  alias xclip-out='xclip -selection clipbloard -o'
fi

if ! command -v nc >/dev/null; then
  alias nc='busybox nc'
fi
