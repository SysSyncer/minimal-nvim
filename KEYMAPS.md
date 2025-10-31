# 🎹 Neovim Keymaps Documentation

## 📋 Table of Contents
- [General](#general)
- [Navigation](#navigation)
- [Editing](#editing)
- [Fuzzy Finder](#fuzzy-finder)
- [LSP & Code](#lsp--code)
- [Comments](#comments)
- [Buffers & Tabs](#buffers--tabs)
- [Window Management](#window-management)
- [File Operations](#file-operations)

---

## General

| Keymap | Description |
|--------|-------------|
| `<Space>` | Leader key |
| `<leader>?` | Show this keymaps help (Which-Key) |
| `K` | Hover documentation (LSP) |

---

## Navigation

| Keymap | Description |
|--------|-------------|
| `<C-h>` | Move focus to left window |
| `<C-j>` | Move focus to down window |
| `<C-k>` | Move focus to up window |
| `<C-l>` | Move focus to right window |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |

---

## Editing

| Keymap | Description |
|--------|-------------|
| `<C-s>` | Save file (normal mode) |
| `<C-s>` | Save file (insert mode) |
| `<C-w>` | Close current buffer |
| `<C-S-q>` | Save and quit |
| `<F2>` | Rename symbol (LSP) |
| `<C-A-l>` | Code actions (LSP) |
| `<C-S-f>` | Format document |
| `<C-k>` | Signature help (LSP) |

---

## Fuzzy Finder (Telescope)

| Keymap | Description |
|--------|-------------|
| `<leader>p` | Find files |
| `<leader>f` | Live grep (search text) |
| `<leader>h` | Help tags |

---

## LSP & Code

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<F2>` | Rename symbol |
| `<C-A-l>` | Code actions |
| `<C-S-f>` | Format document |
| `<C-k>` | Signature help |
| `<C-Space>` | Trigger completion |
| `<Tab>` | Select next completion |
| `<S-Tab>` | Select previous completion |
| `<CR>` | Confirm completion |

---

## Comments

| Keymap | Description |
|--------|-------------|
| `<leader>/` | Toggle comment (normal mode) |
| `<leader>/` | Toggle comment (visual mode) |

---

## Buffers & Tabs

| Keymap | Description |
|--------|-------------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<C-w>` | Close current buffer |
| `<C-b>` | Toggle file tree (nvim-tree) |

---

## Window Management

| Keymap | Description |
|--------|-------------|
| `<C-h>` | Move to left window |
| `<C-l>` | Move to right window |
| `<C-j>` | Move to down window |
| `<C-k>` | Move to up window |

---

## File Operations

| Keymap | Description |
|--------|-------------|
| `<C-s>` | Save file |
| `<C-S-q>` | Save and quit |
| `<C-a>` | Select all |
| `<A-BS>` | Delete previous word (insert mode) |
| `<A-BS>` | Delete previous word (normal mode) |
| `<C-z>` | Disable suspend (mapped to no-op) |

---

## Language-Specific Features

### Python
- Pyright LSP enabled
- Auto-format on save (Black + isort)
- Real-time linting (pylint, flake8 if installed)

### JavaScript/TypeScript
- TypeScript Language Server enabled
- Auto-format on save (Prettier)
- ESLint linting

### Go
- Gopls LSP enabled
- Auto-format on save (goimports + gofmt)
- golangci-lint linting

### Java
- JDTLS LSP enabled
- Maven/Gradle support

---

## Tips & Tricks

1. **Start typing in Telescope**: Use `<C-p>` to find files, then start typing to filter
2. **Live grep**: Press `<C-f>` then type text to search entire project
3. **Comments**: Use `<leader>/` in visual mode to comment multiple lines
4. **Formatting**: Files auto-format on save with configured formatters
5. **Diagnostics**: Hover over errors to see detailed information with `K`
6. **Window navigation**: Use arrow-like keys (`<C-hjkl>`) to move between splits
7. **Completion**: Press `<C-Space>` in any file to trigger autocompletion

---

## Customization

To modify keymaps, edit these files:
- `/Users/venessa/.config/nvim/lua/core/keymaps.lua` - Core keymaps
- `/Users/venessa/.config/nvim/lua/plugins/init.lua` - Plugin keymaps

---

**Last Updated**: October 31, 2025
**Neovim Version**: 0.11.4+
