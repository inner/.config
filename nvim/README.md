# My Neovim Configuration

Personal Neovim configuration based on [NvChad](https://github.com/NvChad/NvChad).

## Features

- Built on top of NvChad for a modern, fast setup
- Custom keybindings and options
- LSP support for multiple languages
- Code formatting with conform.nvim
- Plugin management with lazy.nvim

## Prerequisites

Before installing this configuration, ensure you have the following installed:

### Required

- **Neovim** >= 0.9.5
- **Git** - for cloning and plugin management
- **A Nerd Font** - for icons and glyphs
  - Download from [nerdfonts.com](https://www.nerdfonts.com)
  - Recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font, or Hack Nerd Font
  - Configure your terminal to use the Nerd Font

### Recommended

- **ripgrep** - for Telescope file searching
- **fd** - for better file finding performance
- **Node.js** and **npm** - for LSP servers and TreeSitter
- **xclip** or **wl-clipboard** - for system clipboard support (Linux)

### Fedora Workstation

On Fedora, install the recommended command-line tools, the language servers
enabled by this configuration, and its C/C++ and Python formatters with:

```bash
sudo dnf install -y fd-find golang gopls clang-tools-extra python3-ruff \
  cargo rust rust-analyzer rustfmt
```

This provides `fd`, `go`, `gopls`, `clangd`, `clang-format`, `ruff`, Cargo,
`rustc`, `rust-analyzer`, and `rustfmt`. Git, ripgrep, Node.js/npm, and
`wl-clipboard` are also recommended; install any that are missing with:

```bash
sudo dnf install -y git ripgrep nodejs npm wl-clipboard
```

### Language-Specific Tools

Install language servers for the languages you work with:

```bash
# Python (enabled by this configuration)
npm install -g pyright

# TypeScript/JavaScript (install if you enable its LSP configuration)
npm install -g typescript typescript-language-server
```

The Rust toolchain supplies `rust-analyzer` and `rustfmt`; with rustup, install
the actual components using:

```bash
rustup component add rust-analyzer rustfmt
```

The files in `~/.cargo/bin` may be rustup proxies, so the presence of a
`rust-analyzer` file alone does not mean the component is installed. Verify it
with `rust-analyzer --version`. Both rustup components and Cargo-installed
programs normally live in `~/.cargo/bin`; that directory must be on the `PATH`
of the shell which starts Neovim. The bundled Fish configuration adds it
automatically. Lua files are formatted with Stylua, which can be installed
using `cargo install stylua`. Optional tools, including `lua-language-server`,
can also be installed interactively from Neovim with `:Mason`.

### Configured formatters

| Language | Formatter | Installation source |
| --- | --- | --- |
| Lua | `stylua` | `cargo install stylua` |
| Rust | `rustfmt` | Fedora package or rustup component |
| Go | `gofmt` | Fedora `golang` package |
| Python | `ruff` | Fedora `python3-ruff` package |
| C/C++ | `clang-format` | Fedora `clang-tools-extra` package |

## Installation

### Fresh Installation

1. **Backup existing config** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins. Wait for the installation to complete.

4. **Restart Neovim** after plugins are installed.

## Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── autocmds.lua           # Auto commands
│   ├── chadrc.lua             # NvChad configuration
│   ├── mappings.lua           # Custom keybindings
│   ├── options.lua            # Neovim options
│   ├── configs/               # Plugin configurations
│   │   ├── conform.lua        # Formatting config
│   │   ├── lazy.lua           # Lazy.nvim setup
│   │   └── lspconfig.lua      # LSP configuration
│   └── plugins/               # Plugin specifications
│       └── init.lua
└── .stylua.toml               # Lua formatter config
```

## Neovim Key Cheat Sheet

The leader key is the **Spacebar**. For example, `<leader>ff` means
press `Space`, then `f`, then `f`.

### Files, Search, and Explorer

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>ff` | Normal | Find files |
| `<leader>fa` | Normal | Find all files, including hidden and ignored files |
| `<leader>fw` | Normal | Search text across the project |
| `<leader>fz` | Normal | Search text in the current buffer |
| `<leader>fb` | Normal | Switch open buffers |
| `<leader>fo` | Normal | Find recently opened files |
| `<leader>fh` | Normal | Search Neovim help pages |
| `<leader>ma` | Normal | Find marks |
| `<leader>cm` | Normal | Browse Git commits |
| `<leader>gt` | Normal | Browse Git status |
| `<C-n>` | Normal | Toggle the file tree |
| `<leader>e` | Normal | Focus the file tree, or return to the previous window if the tree is focused |

### LSP and Code

These keys require an active language server for the current file. Use
`:LspInfo` if an LSP key does nothing.

| Keys | Mode | Action |
| --- | --- | --- |
| `K` | Normal | Show hover documentation |
| `gr` | Normal | Find references |
| `<leader>ca` | Normal | Show code actions |
| `<leader>fs` | Normal | Find symbols in the current file |
| `<leader>fS` | Normal | Find symbols in the project |
| `<leader>fm` | Normal, Visual | Format file or selection |
| `grn` | Normal | Rename symbol |
| `gra` | Normal, Visual | Show code actions |
| `grr` | Normal | Find references |
| `gri` | Normal | Go to implementation |
| `grt` | Normal | Go to type definition |
| `gO` | Normal | Show document symbols |
| `[d` / `]d` | Normal | Go to previous / next diagnostic |
| `[D` / `]D` | Normal | Go to first / last diagnostic |

### Editing and Movement

| Keys | Mode | Action |
| --- | --- | --- |
| `jk` | Insert | Leave insert mode |
| `;` | Normal | Enter command mode, same as `:` |
| `<Esc>` | Normal | Clear search highlights |
| `<C-s>` | Normal | Save file |
| `<C-c>` | Normal | Copy the whole file |
| `<leader>/` | Normal, Visual | Toggle comment |
| `<leader>n` | Normal | Toggle line numbers |
| `<leader>rn` | Normal | Toggle relative line numbers |
| `<C-Up>` | Normal, Insert, Visual | Scroll the window up |
| `<C-Down>` | Normal, Insert, Visual | Scroll the window down |
| `<C-S-Up>` | Normal | Move half a page up |
| `<C-S-Down>` | Normal | Move half a page down |
| `<C-Left>` | Normal, Insert, Visual, Command | Move one word left |
| `<C-Right>` | Normal, Insert, Visual, Command | Move one word right |
| `<Down>` | Insert, Select | Select the next IntelliSense item when the completion menu is open; otherwise move down |
| `<Up>` | Insert, Select | Select the previous IntelliSense item when the completion menu is open; otherwise move up |
| `<C-b>` | Insert | Move to the beginning of the line |
| `<C-e>` | Insert | Move to the end of the line |
| `<C-h>` | Insert | Move left |
| `<C-l>` | Insert | Move right |
| `<C-j>` | Insert | Move down |
| `<C-k>` | Insert | Move up |

### Buffers, Windows, and Terminals

| Keys | Mode | Action |
| --- | --- | --- |
| `<Tab>` | Normal | Go to the next buffer |
| `<S-Tab>` | Normal | Go to the previous buffer |
| `<leader>b` | Normal | Open a new buffer |
| `<leader>x` | Normal | Close the current buffer |
| `<C-h>` | Normal | Move to the window on the left |
| `<C-j>` | Normal | Move to the window below |
| `<C-k>` | Normal | Move to the window above |
| `<C-l>` | Normal | Move to the window on the right |
| `<leader>h` | Normal | Open a new horizontal terminal |
| `<leader>v` | Normal | Open a new vertical terminal |
| `<A-h>` | Normal, Terminal | Toggle horizontal terminal |
| `<A-v>` | Normal, Terminal | Toggle vertical terminal |
| `<A-i>` | Normal, Terminal | Toggle floating terminal |
| `<C-x>` | Terminal | Leave terminal mode |

### Help and Discovery

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>ch` | Normal | Open the NvChad cheat sheet |
| `<leader>wK` | Normal | Show all keymaps in WhichKey |
| `<leader>wk` | Normal | Search keymaps in WhichKey |
| `<leader>th` | Normal | Open the NvChad theme picker |
| `<leader>pt` | Normal | Pick a hidden terminal |

## Updating

### Update Configuration

```bash
cd ~/.config/nvim
git pull
```

### Update Plugins

Open Neovim and run:
```vim
:Lazy sync
```

## Customization

- **Keybindings**: Edit `lua/mappings.lua`
- **Options**: Edit `lua/options.lua`
- **Plugins**: Edit `lua/plugins/init.lua`
- **LSP settings**: Edit `lua/configs/lspconfig.lua`

## Troubleshooting

### Plugins not loading

```vim
:Lazy restore
```

### LSP not working

Check if language server is installed:
```vim
:LspInfo
```

For Rust, also verify that the rustup component behind its proxy is installed:

```bash
rustup component add rust-analyzer rustfmt
rust-analyzer --version
```

Open Neovim from a Cargo project (a directory containing `Cargo.toml`) so
`rust-analyzer` can determine the project root.

### Formatter not working

Run `:ConformInfo` to see which formatter Conform selected and whether its
executable was found. This configuration expects `stylua` for Lua, `rustfmt`
for Rust, `gofmt` for Go, `ruff` for Python, and `clang-format` for C/C++.
If a Cargo-installed formatter is reported as unavailable, restart the terminal
after installing it and confirm that `echo $PATH` includes `~/.cargo/bin`.

### Icons not displaying

Ensure your terminal is using a Nerd Font.

## Credits

- [NvChad](https://github.com/NvChad/NvChad) - Main framework
- [LazyVim](https://github.com/LazyVim/LazyVim) - Inspiration for the starter template

## License

See [LICENSE](LICENSE) file for details.
