# Dotfiles by Ghosttino 👻

A modern, minimal development environment focused on productivity and aesthetics. These dotfiles provide a complete setup for software development with carefully chosen tools and configurations.

## 🛠️ Tools & Technologies

### Core Development Stack
- **[Neovim](https://neovim.io/)** - Modern text editor with LSP support (HEAD version)
- **[Ghostty](https://ghostty.io/)** - GPU-accelerated terminal emulator (tip version)
- **[Elvish](https://elv.sh/)** - Expressive programming language and versatile interactive shell
- **[Starship](https://starship.rs/)** - Cross-shell prompt
- **[Homebrew](https://brew.sh/)** - Package manager for macOS

### Development Environment
- **Operating System**: macOS (primary target)
- **Package Management**: Homebrew with `.Brewfile` for reproducible setups
- **Dotfile Management**: GNU Stow for symlink management
- **Python Tooling**: UV for fast package management and tool installation

### Neovim Configuration
- **LSP Support**: Python (Pyright, Ruff, Ty), Lua, C/C++ (Clangd), Rust (rust-analyzer)
- **Completion**: Blink.cmp with intelligent suggestions and LSP integration
- **File Management**: Mini.files for directory browsing and FFF for fuzzy finding
- **Picker/Finder**: Snacks.nvim picker for files, buffers, and project navigation
- **Git Integration**: Gitsigns, Lazygit integration via Snacks
- **Theme**: Jellybeans-mono with transparency support
- **Formatting**: Conform.nvim with Stylua (Lua) and Ruff (Python)
- **Text Objects**: Tree-sitter text objects for enhanced code navigation

### Development Tools
- **Git**: Configured with sensible defaults and comprehensive global ignore patterns
- **Python**: Ruff for linting/formatting, Pyright and Ty for type checking
- **Lua**: Stylua formatting with consistent 2-space indentation
- **Rust**: rust-analyzer with cargo workspace support
- **Version Control**: Extensive gitignore templates for multiple languages and frameworks

## 🎨 Visual Theme

The configuration uses the **Jellybeans-mono** theme throughout:
- Dark background (`#282828`) with warm, muted colors
- Jellybeans color palette with excellent readability
- Berkeley Mono font for crisp text rendering
- Transparent backgrounds where supported
- Consistent theming across terminal and editor

## 🚀 Quick Setup

### Prerequisites

This setup is designed for **macOS** and uses [Homebrew](https://brew.sh/) as the package manager. You'll need:

- **macOS** (tested on recent versions)
- **[Homebrew](https://brew.sh/)** - Install with:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ghosttino/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install all dependencies via Homebrew:**
   ```bash
   brew bundle install --file=.Brewfile
   ```
   This will install everything from the `.Brewfile`:
   - **Terminal & Shell**: `ghostty@tip`, `starship`, `zoxide`
   - **Editor**: `neovim` (HEAD version for latest features)
   - **Development tools**: `git`, `stow`, `fzf`, `lazygit`, `tree-sitter`
   - **Language servers**: `lua-language-server`, `pyright`
   - **Formatters**: `stylua`
   - **Python tooling**: `uv` (modern pip and package manager replacement)

3. **Apply configurations with Stow:**
   ```bash
   stow .
   ```

4. **Install Python tools with uv:**
   ```bash
   # Install ruff for Python linting/formatting
   uv tool install ruff

   # Optional: Install additional Python type checker
   uv tool install ty
   ```

5. **Switch to Elvish shell** (if desired):
   ```bash
   # Add elvish to allowed shells
   echo $(which elvish) | sudo tee -a /etc/shells
   # Change your default shell
   chsh -s $(which elvish)
   ```

6. **Restart your terminal** and enjoy your new development environment!

## 📁 Structure

```
.
├── .Brewfile              # Homebrew dependencies
├── .config/
│   ├── elvish/            # Elvish shell configuration
│   │   └── rc.elv         # Main shell config with aliases
│   ├── ghostty/           # Terminal emulator config and themes
│   │   ├── config         # Main Ghostty configuration
│   │   └── themes/        # Custom color themes
│   ├── nvim/              # Neovim configuration
│   │   ├── lua/           # Lua configuration files
│   │   │   ├── core/      # Core settings and LSP config
│   │   │   └── plugins/   # Plugin configurations
│   │   ├── lsp/           # Language server configs
│   │   └── init.lua       # Main config entry point
│   └── starship.toml      # Prompt configuration
├── .gitconfig             # Git user and core settings
├── .gitignore             # Local repository ignore patterns
├── .gitignore_global      # Global git ignore patterns
├── .stowrc                # Stow configuration
└── .stylua.toml           # Lua formatter config
```

## ⌨️ Key Features & Keybindings

### Elvish Shell
- **Smart aliases**: `v` (nvim), `lg` (lazygit), `lsa` (ls -la)
- **Enhanced navigation**: Zoxide integration for smart directory jumping
- **Starship prompt**: Beautiful, informative command prompt

### Ghostty Terminal
- **Leader key**: `Ctrl+a` (tmux-style)
- **Window management**: `Ctrl+a n` (new), `Ctrl+a x` (close), `Ctrl+a t` (new tab)
- **Splits**: `Ctrl+a /` (right), `Ctrl+a -` (down)
- **Navigation**: `Ctrl+a h/j/k/l` (vim-style movement between splits)
- **Tab navigation**: `Ctrl+a ]` (next), `Ctrl+a [` (previous)

### Neovim
- **Leader key**: `Space`
- **File operations**:
  - `Space Space` - FFF fuzzy file finder
  - `Space ,` - Buffer picker
  - `Space fr` - Recent files
  - `Space fc` - Find config files
- **Git operations**:
  - `Space gg` - Lazygit
  - `Space gb` - Git branches
  - `Space gs` - Git status
  - `Space gl` - Git log
- **Search & navigation**:
  - `Space /` - Live grep
  - `Space sb` - Search buffer lines
  - `Space sw` - Search word under cursor
- **File management**: `-` (Mini.files file browser)
- **Formatting**: `Space ff` or `Space ss` (format current file)
- **Window management**: `ss` (horizontal split), `sv` (vertical split)

### LSP Features
- `gd` - Go to definition
- `gD` - Go to declaration  
- `gs` - Show signature help
- Automatic diagnostics and error highlighting
- Format on save with language-specific formatters

## 🔧 Language Support

### Python
- **LSP**: Pyright for type checking, Ruff for linting
- **Formatting**: Ruff (import sorting, code formatting, linting fixes)
- **Type Checking**: Optional Ty language server for additional type analysis

### Lua
- **LSP**: lua-language-server with Neovim-specific configuration
- **Formatting**: Stylua with 2-space indentation

### Rust
- **LSP**: rust-analyzer with full cargo integration
- **Features**: Macro expansion, cargo workspace reloading

### C/C++
- **LSP**: Clangd with background indexing
- **Project Support**: compile_commands.json and compile_flags.txt

## 🎨 Customization

### Changing Themes
- **Neovim**: Modify `.config/nvim/lua/plugins/jellybeans.lua`
- **Ghostty**: Switch between themes in `.config/ghostty/themes/` or change the `theme` setting in config

### Adding New Tools
1. Add to `.Brewfile` for Homebrew-managed tools
2. Run `brew bundle install` to install new dependencies
3. Add configuration files as needed

### Adding Language Support
1. Add LSP config in `.config/nvim/lsp/[language].lua`
2. Enable in `.config/nvim/lua/core/lsp.lua`
3. Add formatter in `.config/nvim/lua/plugins/conform.lua`
4. Install language server via Homebrew (add to `.Brewfile`)

### Shell Customization
Modify `.config/elvish/rc.elv` for shell functions, aliases, and environment setup.

### Updating Dependencies
Keep everything up to date with:
```bash
brew bundle install    # Install any new dependencies
brew upgrade           # Update existing packages
```

## 🚀 Features Highlight

### Modern Plugin Management
- Uses Neovim's built-in `vim.pack` for plugin management
- Automatic plugin updates with `Space U`
- Lazy loading where beneficial

### Intelligent Code Completion
- Context-aware completions with LSP integration
- File path completions with appropriate icons
- Snippet support and documentation previews

### Advanced Git Integration
- Visual git status in buffers with Gitsigns
- Full Lazygit integration for complex git operations
- Git browsing and project navigation via Snacks

### Enhanced Navigation
- Fuzzy finding for files, buffers, and project content
- Tree-sitter powered text objects for precise code selection
- Smart directory jumping with Zoxide

## 🤝 Contributing

Feel free to:
- Open issues for questions or suggestions
- Submit pull requests for improvements
- Share your customizations and forks

## 📄 License

These dotfiles are available under the MIT License. Feel free to use and modify as needed.

---

*Built with ❤️ for productive development*