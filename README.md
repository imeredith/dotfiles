# dotconfig

Personal dotfiles managed by a simple symlink script.

## Structure

```
files/
  all/    — symlinked on every OS
  mac/    — symlinked on macOS only
  linux/  — symlinked on Linux only
scripts/
  all/    — run on every OS
  mac/    — run on macOS only
  linux/  — run on Linux only
setup.sh  — main entry point
```

## Usage

```sh
./setup.sh
```

Symlinks everything from `files/` into `$HOME` (backing up existing files) and runs all executable scripts in `scripts/`.

## What's configured

| Tool | Description |
|---|---|
| **zsh** | `.zshrc` with Oh My Zsh, zsh-autosuggestions, mise, Homebrew, bun, cargo |
| **tmux** | `.tmux.conf` with mouse, vim-style navigation, popups, and `tmux-sessionizer` |
| **zellij** | Terminal multiplexer config + sessionizer scripts |
| **nvim** | Alias `nvimc` to open config in a floating zellij pane |

## Install scripts

Run individually or via `setup.sh`:

| Script | Platform | Description |
|---|---|---|
| `scripts/all/install-oh-my-zsh` | all | Installs Oh My Zsh and the zsh-autosuggestions plugin |
| `scripts/mac/install-lazygit` | mac | Installs lazygit via Homebrew |
| `scripts/mac/install-tmux` | mac | Installs tmux and fzf via Homebrew |
