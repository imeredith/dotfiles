# Ctrl-f opens tmux-project-manager.
_tmux_project_manager_widget() {
  local bin="$(go env GOBIN)/tmux-project-manager"

  if [[ -n "$TMUX" ]]; then
    tmux display-popup -E -w 80% -h 95% "$bin"
  else
    BUFFER="$bin"
    zle accept-line
  fi
}

zle -N _tmux_project_manager_widget
bindkey '^F' _tmux_project_manager_widget
