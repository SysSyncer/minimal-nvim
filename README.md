# Neovim IDE Configuration

A fully-featured Neovim IDE configuration with multi-language support, LSP integration, auto-formatting, linting, and modern IDE features.

**Neovim Version Required**: 0.11.4+

---

## 📋 Table of Contents

- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Windows](#windows)
- [Configuration Structure](#configuration-structure)
- [Language Support](#language-support)
- [Keymaps](#keymaps)
- [Plugins](#plugins)
- [Troubleshooting](#troubleshooting)

---

## ✨ Features

- 🎨 **Modern UI** - GitHub Dark High Contrast theme with statusline and bufferline
- 🔍 **Fuzzy Finder** - Telescope for file search and live grep
- 💬 **Code Comments** - Toggle comments with a single keymap
- 📝 **Auto-Formatting** - Automatic code formatting on save
- 🔧 **Linting** - Real-time code linting for multiple languages
- 🎯 **Code Completion** - LSP-powered autocompletion with snippets
- 📂 **File Explorer** - nvim-tree for project navigation
- 🖥️ **Terminal** - Built-in terminal with toggleterm.nvim
- 🔴 **Inline Diagnostics** - Virtual text showing errors and warnings
- 🌐 **Multi-Language** - Python, JavaScript, TypeScript, Go, Java support

---

## 🚀 Installation

### Prerequisites

#### All Platforms

1. **Neovim 0.11.4+**
   ```bash
   nvim --version
   ```

2. **Git**
   ```bash
   git --version
   ```

3. **Node.js & npm** (for some LSP servers)
   - [Download Node.js](https://nodejs.org/)

---

### macOS

#### Step 1: Install Neovim (if not already installed)

```bash
brew install neovim
```

#### Step 2: Install Configuration

```bash
# Clone or copy this config to Neovim's config directory
git clone https://github.com/yourusername/nvim-config ~/.config/nvim
cd ~/.config/nvim
```

#### Step 3: Install Language Tools

Install these via Homebrew:

```bash
# Python tools
brew install python3 black

pip3 install pyright pylint flake8 isort

# JavaScript/TypeScript tools
npm install -g prettier eslint typescript

# Go tools
brew install go
brew install golangci-lint

# Java tools
brew install openjdk

# Linting & Formatting
brew install fd ripgrep  # For Telescope
```

#### Step 4: Launch Neovim

```bash
nvim
```

Lazy.nvim will automatically download and install all plugins on first launch.

---

### Linux

#### Step 1: Install Neovim

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install neovim
```

**Fedora:**
```bash
sudo dnf install neovim
```

**Arch:**
```bash
sudo pacman -S neovim
```

#### Step 2: Install Configuration

```bash
git clone https://github.com/yourusername/nvim-config ~/.config/nvim
cd ~/.config/nvim
```

#### Step 3: Install Language Tools

**Ubuntu/Debian:**
```bash
# Python
sudo apt install python3 python3-pip
pip3 install pyright pylint flake8 isort black

# JavaScript/TypeScript
sudo apt install npm
npm install -g prettier eslint typescript

# Go
sudo apt install golang-go
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Java
sudo apt install default-jdk

# Utils
sudo apt install fd-find ripgrep
```

**Fedora:**
```bash
# Python
sudo dnf install python3 python3-pip
pip3 install pyright pylint flake8 isort black

# JavaScript/TypeScript
sudo dnf install npm
npm install -g prettier eslint typescript

# Go
sudo dnf install golang
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Java
sudo dnf install java-latest-openjdk

# Utils
sudo dnf install fd ripgrep
```

**Arch:**
```bash
# Python
sudo pacman -S python python-pip
pip install pyright pylint flake8 isort black

# JavaScript/TypeScript
sudo pacman -S npm
npm install -g prettier eslint typescript

# Go
sudo pacman -S go
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Java
sudo pacman -S jdk-openjdk

# Utils
sudo pacman -S fd ripgrep
```

#### Step 4: Launch Neovim

```bash
nvim
```

---

### Windows

#### Step 1: Install Neovim

Using **Chocolatey**:
```powershell
choco install neovim
```

Or **Scoop**:
```powershell
scoop install neovim
```

Or download from [Neovim Releases](https://github.com/neovim/neovim/releases)

#### Step 2: Install Configuration

```powershell
git clone https://github.com/yourusername/nvim-config $env:LOCALAPPDATA\nvim
cd $env:LOCALAPPDATA\nvim
```

#### Step 3: Install Language Tools

**Using Chocolatey:**
```powershell
# Python
choco install python

# Node.js & Tools
choco install nodejs

# Go
choco install golang

# Java
choco install openjdk

# Git tools
choco install git

# Python packages
pip install pyright pylint flake8 isort black

# Node packages
npm install -g prettier eslint typescript
```

**Using scoop:**
```powershell
# Python
scoop install python

# Node.js
scoop install nodejs

# Go
scoop install go

# Java
scoop install openjdk

# Tools
scoop install fd ripgrep git
```

#### Step 4: Launch Neovim

```powershell
nvim
```

---

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json          # Plugin lock file
├── README.md               # This file
├── lua/
│   ├── core/
│   │   ├── options.lua     # Editor settings
│   │   └── keymaps.lua     # Core keymaps
│   └── plugins/
│       └── init.lua        # Plugin specs & LSP config
```

---

## 🌐 Language Support

| Language | LSP | Formatter | Linter | Features |
|----------|-----|-----------|--------|----------|
| **Python** | Pyright | Black, isort | pylint, flake8 | ✅ Format on save |
| **JavaScript** | ts_ls | Prettier | ESLint | ✅ Format on save |
| **TypeScript** | ts_ls | Prettier | ESLint | ✅ Format on save |
| **Go** | gopls | goimports, gofmt | - | ✅ Format on save |
| **Java** | JDTLS | - | - | ✅ LSP support |

### Python Setup

Pyright looks for virtual environments in `.venv/` directories. Create one:

```bash
python3 -m venv .venv
source .venv/bin/activate  # macOS/Linux
# or
.venv\Scripts\activate  # Windows
```

---

## 🎹 Keymaps

### General

| Keymap | Description |
|--------|-------------|
| `<Space>` | Leader key |
| `K` | Hover documentation (LSP) |

### Navigation

| Keymap | Description |
|--------|-------------|
| `<C-h>` | Move focus to left window |
| `<C-j>` | Move focus to down window |
| `<C-k>` | Move focus to up window |
| `<C-l>` | Move focus to right window |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |

### Editing

| Keymap | Description |
|--------|-------------|
| `<C-s>` | Save file |
| `<C-w>` | Close current window |
| `<C-S-q>` | Save and quit all |
| `<C-a>` | Select all |
| `<F2>` | Rename symbol (LSP) |
| `<C-A-l>` | Code actions (LSP) |
| `<C-S-f>` | Format document |
| `<C-k>` | Signature help (LSP) |

### Fuzzy Finder (Telescope)

| Keymap | Description |
|--------|-------------|
| `<leader>p` | Find files |
| `<leader>f` | Live grep (search text) |
| `<leader>h` | Help tags |

### Comments

| Keymap | Description |
|--------|-------------|
| `<leader>/` | Toggle comment (normal mode) |
| `<leader>/` | Toggle comment (visual mode) |

### Buffers & Tabs

| Keymap | Description |
|--------|-------------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<C-b>` | Toggle file tree |

### Window Management

| Keymap | Description |
|--------|-------------|
| `<leader>v` | Vertical split |
| `<leader>s` | Horizontal split |
| `<C-h/j/k/l>` | Move between windows |

### Terminal

| Keymap | Description |
|--------|-------------|
| `<C-\>` | Toggle terminal |
| `<leader>t` | Toggle terminal |

### LSP & Code Completion

| Keymap | Description |
|--------|-------------|
| `<C-Space>` | Trigger completion |
| `<Tab>` | Select next item |
| `<S-Tab>` | Select previous item |
| `<CR>` | Confirm selection |
| `<C-k>` | Show function signature |

---

## 🔌 Plugins

### Core Plugins

- **lazy.nvim** - Plugin manager
- **mason.nvim** - Package manager for LSPs, formatters, linters
- **nvim-cmp** - Autocompletion engine
- **nvim-lspconfig** - LSP configuration
- **LuaSnip** - Snippet engine

### UI Plugins

- **github-nvim-theme** - GitHub Dark High Contrast theme
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Tab bar
- **nvim-tree.lua** - File explorer

### Productivity Plugins

- **telescope.nvim** - Fuzzy finder
- **Comment.nvim** - Comment toggle
- **toggleterm.nvim** - Terminal integration
- **nvim-autopairs** - Auto-pair brackets
- **lsp_lines.nvim** - Inline diagnostics

### Formatting & Linting

- **conform.nvim** - Code formatting
- **nvim-lint** - Code linting

---

## 🐛 Troubleshooting

### LSP not starting for Python

**Problem**: Pyright not detecting your Python environment

**Solution**: Create a `.venv` directory in your project root:
```bash
python3 -m venv .venv
```

Or create a `pyrightconfig.json`:
```json
{
  "venv": ".venv",
  "pythonVersion": "3.11"
}
```

### Format on save not working

**Problem**: Files not auto-formatting on save

**Solution**:
1. Verify formatter is installed:
   ```bash
   which black prettier gofmt
   ```

2. Check conform.nvim is loaded:
   ```vim
   :ConformInfo
   ```

3. Manually format to test:
   ```vim
   :Format
   ```

### Telescope not finding files

**Problem**: Telescope can't find files

**Solution**: Install required tools:

```bash
# macOS
brew install fd ripgrep

# Ubuntu/Debian
sudo apt install fd-find ripgrep

# Fedora
sudo dnf install fd ripgrep

# Arch
sudo pacman -S fd ripgrep

# Windows (Chocolatey)
choco install fd ripgrep
```

### Terminal not opening

**Problem**: `<C-\>` not opening terminal

**Solution**: Check toggleterm is installed:
```vim
:ToggleTerm
```

If it fails, ensure the plugin is properly installed by running:
```vim
:Lazy sync
```

### Completion not working

**Problem**: Autocompletion not showing

**Solution**:
1. Verify LSP is running: `<C-Space>` in edit mode
2. Check if LSP started: `:LspInfo`
3. Try manual trigger: `<C-Space>`

---

## 📝 Tips & Tricks

1. **Search project-wide**: Press `<leader>f` with Telescope to search entire project
2. **Comment blocks**: Select lines in visual mode and press `<leader>/`
3. **Window navigation**: Use `<C-h/j/k/l>` to move between split windows
4. **Terminal**: Open terminal with `<leader>t` for quick shell access
5. **Hover docs**: Press `K` on any symbol to see documentation
6. **Code actions**: Press `<C-A-l>` to see available quick-fix actions
7. **Rename symbol**: Press `<F2>` to rename across your codebase

---

## 🔧 Customization

Edit these files to customize your config:

- **Keymaps**: `~/.config/nvim/lua/core/keymaps.lua`
- **Options**: `~/.config/nvim/lua/core/options.lua`
- **Plugins**: `~/.config/nvim/lua/plugins/init.lua`

---

## 📦 Dependency Summary

### Required

- Neovim 0.11.4+
- Git
- Node.js & npm

### Optional (by language)

**Python**: pyright, black, isort, pylint, flake8

**JavaScript/TypeScript**: prettier, eslint, typescript

**Go**: go, goimports, golangci-lint

**Java**: JDK, JDTLS (auto-installed via Mason)

---

## 📄 License

This configuration is provided as-is. Feel free to modify and adapt it to your needs.

---

**Last Updated**: October 31, 2025  
**Neovim Version**: 0.11.4+
