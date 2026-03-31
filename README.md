# .config

Personal dotfiles for a Linux development environment — version-controlled and deployable across machines.

## Contents

### Shell — [fish/](fish/)
- Custom prompt, aliases, and abbreviations for daily workflows
- Package management shortcuts (`i`, `u`, `r`) targeting `dnf` (Fedora/RHEL)
- Quick aliases: `vim` → `nvim`, `docker` → `podman`, `c` → `claude`, `g` → `cd ~/github`
- [Fisher](https://github.com/jorgebucaran/fisher) plugin manager with Gruvbox theme

### Editor — [nvim/](nvim/)
- [NvChad](https://nvchad.com/) v2.5 as the base framework, theme: gruvchad (Gruvbox)
- LSP configured for Rust, Go, Python, C/C++
- Code formatting via [conform.nvim](https://github.com/stevearc/conform.nvim)
- File tree ([nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)), smart column ruler (80/100 chars)
- See [nvim/README.md](nvim/README.md) for keybindings and full details

### Terminal — [alacritty/](alacritty/)
- Font: FiraCode Nerd Font, size 12
- Shell: Fish, window title: `:: netrunner ::`
- Theme: Gruvbox Material Hard Dark (17 themes available in `themes/`)

### Multiplexer — [tmux/](tmux/)
- Prefix: `` ` `` (backtick)
- Default shell: Fish

## Setup

Clone into `~/.config`:

```sh
git clone https://github.com/inner/.config ~/.config
```

Neovim plugins will be installed automatically on first launch via lazy.nvim.

For Fish plugins, install Fisher and run:

```sh
fisher update
```
