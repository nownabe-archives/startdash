# ghq + peco

peco-src() {
  local selected
  selected="$(ghq list --full-path | peco --query="$LBUFFER")"
  if [ -n "$selected" ]; then
    BUFFER="cd $selected"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-src
