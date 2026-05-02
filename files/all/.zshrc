export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
plugins=(git zsh-autosuggestions)

eval "$($HOME/.local/bin/mise activate zsh)"

export PATH="$HOME/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

if [ -d "$HOME/.zshrc.d" ]; then
  for zsh_file in "$HOME/.zshrc.d"/*.zsh; do
    [ -e "$zsh_file" ] || continue
    . "$zsh_file"
  done
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
source $HOME/.local/bin/env
. "$HOME/.cargo/env"

source "$ZSH/oh-my-zsh.sh"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
