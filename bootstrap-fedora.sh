#!/usr/bin/env bash

set -Eeuo pipefail

# Bootstrap this repository on a Fedora workstation. The script is deliberately
# idempotent: packages may already be installed, fonts may already exist, and
# links that already point into this checkout are left untouched.

readonly REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_SUFFIX="backup.$(date +%Y%m%d-%H%M%S)"

# Use the same user-local program locations that the linked Fish configuration
# exposes. This also lets the bootstrap verify tools installed earlier in this
# run without requiring a terminal restart first.
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

log() {
  printf '\n\033[1;34m==> %s\033[0m\n' "$*"
}

note() {
  printf '    %s\n' "$*"
}

die() {
  printf '\nERROR: %s\n' "$*" >&2
  exit 1
}

command -v dnf >/dev/null 2>&1 || die "This bootstrap script requires Fedora's dnf package manager."
command -v sudo >/dev/null 2>&1 || die "sudo is required to install packages and fonts."

log "Repository"
note "$REPO_ROOT"

log "Requesting administrator access"
note "sudo is used for dnf packages and files under /usr/share/fonts."
sudo -v

packages=(
  alacritty
  clang-tools-extra
  cmake
  cargo
  fd-find
  fish
  fontconfig
  gcc
  gcc-c++
  git
  gh
  golang
  gopls
  make
  neovim
  nodejs
  npm
  python3-ruff
  ripgrep
  rust
  rust-analyzer
  rustfmt
  ShellCheck
  tmux
  wl-clipboard
)

log "Installing Fedora packages"
note "${packages[*]}"
sudo dnf install -y "${packages[@]}"

# A rustup proxy can appear executable even when its backing component is
# absent. In that state Neovim reports that rust-analyzer is not executable, so
# explicitly install both components whenever this machine uses rustup.
if command -v rustup >/dev/null 2>&1; then
  log "Installing Rust editor components"
  rustup component add rust-analyzer rustfmt
fi

log "Installing npm-based language servers"
note "Pyright, TypeScript, and typescript-language-server"
sudo npm install --global pyright typescript typescript-language-server

if command -v cargo >/dev/null 2>&1; then
  log "Installing the Lua formatter"
  if command -v stylua >/dev/null 2>&1; then
    note "Stylua is already installed: $(command -v stylua)"
  else
    cargo install stylua
  fi
else
  note "Cargo was not found; skipping Stylua. Install Rust with rustup, then run: cargo install stylua"
fi

link_config() {
  local source=$1
  local target=$2
  local backup

  if [[ -L "$target" ]] && [[ "$(readlink -f -- "$target")" == "$(readlink -f -- "$source")" ]]; then
    note "Already linked: $target -> $source"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup="${target}.${BACKUP_SUFFIX}"
    note "Backing up: $target -> $backup"
    mv -- "$target" "$backup"
  fi

  note "Linking: $target -> $source"
  ln -s -- "$source" "$target"
}

log "Creating configuration links"
mkdir -p -- "$HOME/.config"
link_config "$REPO_ROOT/alacritty" "$HOME/.config/alacritty"
link_config "$REPO_ROOT/fish" "$HOME/.config/fish"
link_config "$REPO_ROOT/nvim" "$HOME/.config/nvim"
link_config "$REPO_ROOT/tmux" "$HOME/.config/tmux"
link_config "$REPO_ROOT/git/.gitconfig" "$HOME/.gitconfig"

log "Installing bundled fonts"
while IFS= read -r -d '' font; do
  relative_path=${font#"$REPO_ROOT/fonts/"}
  destination="/usr/share/fonts/${relative_path}"
  note "$relative_path"
  sudo install -D -m 0644 -- "$font" "$destination"
done < <(find "$REPO_ROOT/fonts" -type f \( -iname '*.ttf' -o -iname '*.ttc' -o -iname '*.otf' \) -print0)

note "Refreshing the system font cache"
sudo fc-cache --force

log "Verifying the Git author identity"
git_name=$(git config --global --get user.name || true)
git_email=$(git config --global --get user.email || true)
[[ -n "$git_name" ]] || die "user.name is missing from $REPO_ROOT/git/.gitconfig"
[[ -n "$git_email" ]] || die "user.email is missing from $REPO_ROOT/git/.gitconfig"
note "Git commits will use: $git_name <$git_email>"

log "Verifying Neovim language tools and formatters"
editor_tools=(
  clang-format
  gofmt
  gopls
  pyright-langserver
  ruff
  rust-analyzer
  rustfmt
  stylua
  typescript-language-server
)
for tool in "${editor_tools[@]}"; do
  command -v "$tool" >/dev/null 2>&1 || die "$tool is unavailable on PATH: $PATH"
  note "$tool: $(command -v "$tool")"
done

# Unlike a missing binary, a missing rustup component leaves behind a proxy
# which `command -v` considers valid. Running the version check catches that
# misleading state before the user opens Neovim.
rust-analyzer --version
rustfmt --version

log "Bootstrap complete"
note "Start Neovim once and allow lazy.nvim to finish installing plugins."
note "Restart your terminal or run 'exec fish' to load the Fish configuration."
