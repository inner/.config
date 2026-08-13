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

### Language-Specific Tools

Install language servers for the languages you work with:

```bash
# Example: Install common language servers
npm install -g typescript-language-server
npm install -g pyright
npm install -g lua-language-server
```

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

### Icons not displaying

Ensure your terminal is using a Nerd Font.

## Credits

- [NvChad](https://github.com/NvChad/NvChad) - Main framework
- [LazyVim](https://github.com/LazyVim/LazyVim) - Inspiration for the starter template

## License

See [LICENSE](LICENSE) file for details.
