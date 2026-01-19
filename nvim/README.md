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
