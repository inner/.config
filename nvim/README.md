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

## Keybindings & Commands

This configuration is built on **NvChad v2.5**, which provides many default keybindings. The mappings below include both custom keybindings specific to this configuration and commonly used NvChad defaults. For a complete list of NvChad defaults, refer to the [NvChad mappings documentation](https://nvchad.com/docs/config/mappings).

### Leader Key

The leader key is set to **`Space`** (default in NvChad).

### Basic Navigation & Editing

| Mode | Keybinding | Action | Description |
|------|------------|--------|-------------|
| Insert | `jk` | ESC | Exit insert mode (custom) |
| Normal | `;` | `:` | Enter command mode (custom) |
| Normal | `<Ctrl-s>` | Save | Save current file |

### File & Tree Navigation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>e` | Toggle NvimTree focus | Toggle focus between editor and file tree (custom) |
| `Ctrl+n` | Toggle NvimTree | Open/close file explorer |

### LSP Commands

#### Code Navigation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gD` | Go to declaration | Jump to symbol declaration |
| `gi` | Go to implementation | Jump to symbol implementation |
| `gr` | Go to references | Show all references (via Telescope, custom) |

#### Code Actions & Refactoring

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ca` | Code action | Show available code actions (custom) |
| `<leader>ra` | Rename symbol | Rename symbol under cursor |

#### Diagnostics

| Keybinding | Action | Description |
|------------|--------|-------------|
| `[d` | Previous diagnostic | Jump to previous diagnostic |
| `]d` | Next diagnostic | Jump to next diagnostic |
| `<leader>q` | Diagnostic loclist | Show diagnostics in location list |

#### Hover & Documentation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `K` | Hover documentation | Show documentation for symbol under cursor (custom) |

### Telescope (Fuzzy Finder)

#### Symbol Finding

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>fs` | Document symbols | Find symbols in current file (custom) |
| `<leader>fS` | Workspace symbols | Find symbols across project (custom) |

#### File Finding

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ff` | Find files | Search for files in project |
| `<leader>fa` | Find all files | Search all files (including hidden) |
| `<leader>fw` | Find word | Live grep search in project |
| `<leader>fb` | Find buffers | Search open buffers |
| `<leader>fh` | Find help | Search help tags |
| `<leader>fo` | Find old files | Search recent files |
| `<leader>fz` | Find current buffer | Fuzzy find in current buffer |

#### Git Operations

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>cm` | Git commits | Browse git commits |
| `<leader>gt` | Git status | Show git status via Telescope |

#### Other Telescope Features

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ma` | Find marks | Search marks |
| `<leader>th` | Themes | Select colorscheme |

### Code Formatting

This configuration uses **conform.nvim** for code formatting with the following formatters:

- **Lua**: `stylua`
- **Rust**: `rustfmt`
- **C/C++**: `clang-format`

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>fm` | Format file | Manually format current file |

**Note**: Format-on-save is enabled by default (500ms timeout).

### Terminal Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>h` | Horizontal terminal | Open terminal in horizontal split |
| `<leader>v` | Vertical terminal | Open terminal in vertical split |
| `<Alt-h>` | Toggle horizontal term | Toggle horizontal terminal |
| `<Alt-v>` | Toggle vertical term | Toggle vertical terminal |
| `<Alt-i>` | Toggle floating term | Toggle floating terminal |
| `<Ctrl-x>` | Exit terminal mode | Exit terminal mode (in terminal) |

### Buffer Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<Tab>` | Next buffer | Go to next buffer |
| `<Shift-Tab>` | Previous buffer | Go to previous buffer |
| `<leader>x` | Close buffer | Close current buffer |
| `<leader>b` | New buffer | Create new buffer |

### Window Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<Ctrl-h>` | Move to left window | Navigate to left window |
| `<Ctrl-j>` | Move to bottom window | Navigate to bottom window |
| `<Ctrl-k>` | Move to top window | Navigate to top window |
| `<Ctrl-l>` | Move to right window | Navigate to right window |

### Comment Toggle

| Mode | Keybinding | Action | Description |
|------|------------|--------|-------------|
| Normal | `gcc` | Toggle line comment | Comment/uncomment current line |
| Normal | `gbc` | Toggle block comment | Comment/uncomment as block |
| Visual | `gc` | Toggle line comment | Comment/uncomment selected lines |
| Visual | `gb` | Toggle block comment | Comment/uncomment selection as block |

### NvimTree File Explorer

When focused in NvimTree, use these keybindings:

| Keybinding | Action | Description |
|------------|--------|-------------|
| `a` | Create file/folder | Create new file or folder |
| `d` | Delete | Delete file/folder |
| `r` | Rename | Rename file/folder |
| `x` | Cut | Cut file/folder |
| `c` | Copy | Copy file/folder |
| `p` | Paste | Paste file/folder |
| `y` | Copy name | Copy filename |
| `Y` | Copy relative path | Copy relative path |
| `gy` | Copy absolute path | Copy absolute path |
| `I` | Toggle hidden files | Show/hide hidden files |
| `H` | Toggle dotfiles | Show/hide dotfiles |
| `R` | Refresh | Refresh file tree |
| `<CR>` or `o` | Open | Open file or expand folder |
| `<BS>` | Close folder | Close parent folder |
| `q` | Quit | Close NvimTree |

### Plugin Management

This configuration uses **lazy.nvim** for plugin management.

| Command | Description |
|---------|-------------|
| `:Lazy` | Open Lazy plugin manager UI |
| `:Lazy sync` | Update plugins (install, update, clean) |
| `:Lazy install` | Install missing plugins |
| `:Lazy update` | Update plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy restore` | Restore plugins to lockfile state |

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
