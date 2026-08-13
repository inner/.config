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

## Neovim Command Cheat Page

The leader key is the **Spacebar**. In command examples, `<leader>e`
means press `Space`, then `e`.

### Daily Navigation

| Keys | Mode | Action |
| --- | --- | --- |
| `jk` | Insert | Leave insert mode |
| `;` | Normal | Enter command mode, same as `:` |
| `<leader>e` | Normal | Focus the file tree, or return to the previous window if the tree is focused |
| `<C-Up>` | Normal, Insert, Visual | Scroll the window up |
| `<C-Down>` | Normal, Insert, Visual | Scroll the window down |
| `<C-S-Up>` | Normal | Move half a page up |
| `<C-S-Down>` | Normal | Move half a page down |
| `<C-Left>` | Normal, Insert, Visual, Command | Move one word left |
| `<C-Right>` | Normal, Insert, Visual, Command | Move one word right |

### Search and Files

| Command | Action |
| --- | --- |
| `:Telescope find_files` | Find files |
| `:Telescope live_grep` | Search text across the project |
| `:Telescope buffers` | Switch open buffers |
| `:Telescope help_tags` | Search Neovim help |
| `:NvimTreeToggle` | Toggle the file tree |
| `:NvimTreeFindFile` | Reveal the current file in the tree |

### LSP and Code

| Keys or Command | Action |
| --- | --- |
| `K` | Show hover documentation |
| `gr` | Find references |
| `<leader>fs` | Find symbols in the current file |
| `<leader>fS` | Find symbols in the project |
| `<leader>ca` | Show code actions |
| `:LspInfo` | Show active language servers |
| `:Mason` | Manage language servers and tools |
| `:lua vim.lsp.buf.rename()` | Rename the symbol under the cursor |

### Editing Essentials

| Keys or Command | Action |
| --- | --- |
| `i` / `a` | Insert before / after the cursor |
| `o` / `O` | Open a new line below / above |
| `v` / `V` | Start character / line visual selection |
| `y` / `yy` | Yank selection / current line |
| `p` / `P` | Paste after / before the cursor |
| `d` / `dd` | Delete selection / current line |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat the previous change |
| `:%s/old/new/g` | Replace `old` with `new` in the whole file |

### Buffers, Windows, and Tabs

| Command | Action |
| --- | --- |
| `:w` | Save the current file |
| `:q` | Quit the current window |
| `:qa` | Quit Neovim |
| `:bd` | Delete the current buffer |
| `:split` | Open a horizontal split |
| `:vsplit` | Open a vertical split |
| `<C-w>h/j/k/l` | Move between windows |
| `<C-w>=` | Balance split sizes |
| `:tabnew` | Open a new tab |
| `gt` / `gT` | Go to next / previous tab |

### Plugins and Maintenance

| Command | Action |
| --- | --- |
| `:Lazy` | Open the plugin manager |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy restore` | Restore plugins from `lazy-lock.json` |
| `:checkhealth` | Run Neovim health checks |
| `:ConformInfo` | Show formatter status |

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
