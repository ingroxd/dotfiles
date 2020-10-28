# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ]; then
  PATH="${HOME}/.local/bin:${PATH}"
fi

if command -v rbenv >/dev/null && [ -d ~/.rbenv/bin ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi

