
# Dark Neovim Configuration

A modern, feature-rich Neovim configuration using lazy.nvim for plugin management. This setup provides a comprehensive development environment with support for multiple languages, debugging capabilities, and a clean, efficient interface.

## Features

- **Plugin Management**: Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin loading
- **LSP Support**: Integrated Language Server Protocol for intelligent code completion and analysis
- **Debugging**: Built-in debugging for multiple languages (Python, Rust, Go, C++, JavaScript)
- **Git Integration**: Seamless git workflow with lazygit and gitsigns
- **Modern UI**: Beautiful interface with customizable themes, statusline, and dashboard
- **Productivity Tools**: File explorer, fuzzy finder, auto-completion, and more
- **Language Support**: Enhanced experience for multiple programming languages

## Installation

### Prerequisites

- Neovim (v0.8.0 or higher recommended)
- Git
- [Nerd Fonts](https://www.nerdfonts.com/) (for icons)
- Node.js and npm (for certain LSP servers)
- Python 3 (for certain plugins)

### Setup

1. Back up your existing Neovim configuration if necessary:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/Ahsene3/dark-nvim.git ~/.config/nvim
   ```

3. Launch Neovim:
   ```bash
   nvim
   ```

4. The configuration will automatically install lazy.nvim and all plugins on first launch.

## Structure

```
├── init.lua                 # Main configuration entry point
├── lazy-lock.json           # Plugin version lock file
├── lua
│   └── dark                 # Configuration namespace
│       ├── core             # Core configuration
│       │   ├── filetypes.lua   # Filetype-specific settings
│       │   ├── init.lua        # Core module initialization
│       │   ├── keymaps.lua     # Key mappings
│       │   └── options.lua     # Neovim options
│       ├── lazy.lua         # Lazy.nvim setup
│       └── plugins          # Plugin configurations
│           ├── ...          # Individual plugin configuration files
│           ├── debug        # Debugging configurations for languages
│           │   ├── cpp.lua
│           │   ├── go.lua
│           │   ├── js.lua
│           │   ├── python.lua
│           │   └── rust.lua
│           ├── lsp          # LSP configurations
│           │   ├── lspconfig.lua
│           │   └── mason.lua
│           └── ...
```

## Key Plugins

- **[alpha-nvim](https://github.com/goolord/alpha-nvim)**: Start screen dashboard
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**: Buffer line for tabs
- **[nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)**: File explorer
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: Fuzzy finder
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Completion engine
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)**: LSP/DAP/Linter/Formatter manager
- **[treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Syntax highlighting
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)**: Git integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Git decorations
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: Status line
- **[which-key.nvim](https://github.com/folke/which-key.nvim)**: Displays key bindings
- **[auto-session](https://github.com/rmagatti/auto-session)**: Session management
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)**: Debug Adapter Protocol

## Key Mappings

The configuration uses `<Space>` as the leader key. Here are some of the most useful keybindings:

| Mapping | Mode | Description |
|---------|------|-------------|
| `<Space>ff` | Normal | Find files |
| `<Space>fg` | Normal | Live grep |
| `<Space>e` | Normal | Toggle file explorer |
| `<Space>b` | Normal | Buffer management |
| `<Space>g` | Normal | Git commands |
| `<Space>lf` | Normal | Format document |
| `<Space>lr` | Normal | Rename symbol |
| `<Space>ld` | Normal | Go to definition |
| `<Space>d` | Normal | Debug commands |
| `<Space>t` | Normal | Toggle terminal |

For a complete list of keybindings, check the `lua/dark/core/keymaps.lua` file or use the which-key plugin by pressing the leader key.

## Language Support

This configuration provides enhanced support for:
- Python
- Rust
- C/C++
- Go
- JavaScript/TypeScript
- And more...

Each language has specific LSP, debugger, and formatter configurations.

## Customization

### Adding New Plugins

Create a new file in the `lua/dark/plugins` directory:

```lua
-- lua/dark/plugins/your-plugin.lua
return {
  "username/plugin-name",
  config = function()
    -- Plugin configuration
  end,
  dependencies = {
    -- Dependencies if any
  }
}
```

### Modifying Settings

- **Core Settings**: Edit files in `lua/dark/core/`
- **Plugin Settings**: Edit files in `lua/dark/plugins/`
- **LSP Settings**: Edit files in `lua/dark/plugins/lsp/`
- **Debugging**: Edit files in `lua/dark/plugins/debug/`

## Troubleshooting

### Common Issues

1. **Plugin not loading**: Check the `lazy-lock.json` file to ensure the plugin is properly installed
2. **LSP not working**: Ensure the language server is installed via Mason (`:Mason`)
3. **Icons not showing**: Make sure you have a Nerd Font installed and configured

### Health Check

Run `:checkhealth` to identify any issues with your configuration.

## Updating

Update all plugins with:
```
:Lazy update
```

## Credits

This configuration is inspired by and built upon the work of many in the Neovim community. Special thanks to:

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [NvChad](https://github.com/NvChad/NvChad)

## License

MIT

---

Made with ❤️ by [Your Name]
