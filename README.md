# .config

Personal Linux dotfiles for a development-oriented workstation.

This repository tracks the configs I actually use for shell, editor,
terminal, and tmux so they can be cloned onto a new machine without
rebuilding everything from scratch.

## Layout

### [fish/](fish/)

Fish is the interactive shell baseline for this setup.

- Adds `~/.local/bin` to `PATH`
- Disables the default Fish greeting
- Defines Fedora/RHEL-oriented `dnf` shortcuts such as `i`, `iy`, `u`,
  `uy`, `r`, and `ry`
- Adds workflow aliases such as `vim` -> `nvim`, `c` -> `codex`, `g` ->
  `cd ~/github`, and `o` -> `xdg-open`
- Provides a `push` abbreviation that stages changes, commits with a
  default `+upd` message, and pushes
- Includes Fisher files and prompt/theme helpers

### [nvim/](nvim/)

Neovim is built on top of [NvChad](https://nvchad.com/) `v2.5` and
bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) on first
launch.

- Custom options, mappings, and autocmds
- LSP setup for `rust_analyzer`, `clangd`, `gopls`, and `pyright`
- Formatting through
  [conform.nvim](https://github.com/stevearc/conform.nvim)
- File tree via
  [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- Smart color columns at `80`, with `100` for Rust, Go, and Python

See [nvim/README.md](nvim/README.md) for editor-specific notes.

### [alacritty/](alacritty/)

Alacritty uses Fish as the shell and keeps a large local theme library.

- Default imported theme: `themes/linux.toml`
- Font: `FiraCode Nerd Font Mono`
- Font size: `12`
- Window title: `:: netrunner ::`
- Default window size: `160x55`
- `F11` toggles fullscreen

### [tmux/](tmux/)

Tmux is configured to stay minimal and keyboard-focused.

- Default shell: Fish
- Prefix key: `` ` ``
- Mouse support enabled
- Vi-style copy and selection keys enabled

### [fonts/](fonts/)

Bundled fonts used by the terminal and editor setup.

- FiraCode Nerd Font
- Iosevka
- JetBrains Mono
- Noto Sans Mono

## Setup

This repository is intended to live at `~/github/.config`, with selected
directories linked into the real `~/.config` directory. The files stay
source-controlled in the repository, while applications continue to read
their usual config paths.

The current setup uses manual symlinks rather than Stow:

```sh
ln -s ~/github/.config/alacritty ~/.config/alacritty
ln -s ~/github/.config/fish ~/.config/fish
ln -s ~/github/.config/nvim ~/.config/nvim
ln -s ~/github/.config/tmux ~/.config/tmux
```

Before creating a link, move aside any existing real directory at the
target path, such as `~/.config/nvim`, so the symlink can take its
place.

## Post-Clone Notes

- Start `nvim` once to let `lazy.nvim` install plugins
- Install Fisher if you want to manage Fish plugins with `fisher update`
- Ensure a Nerd Font is installed and selected in your terminal
