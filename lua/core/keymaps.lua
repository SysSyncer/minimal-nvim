-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true })  -- delete previous word in insert mode
vim.keymap.set("n", "<A-BS>", "db", { noremap = true })     -- delete previous word in normal mode

-----------------------------------------------------------
-- 🔧 Custom Keymaps (Ctrl + shortcuts)
-----------------------------------------------------------

-- Set space as leader key (optional but recommended)
vim.g.mapleader = " "

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true }) -- works in insert mode too

-- Close current buffer (like closing a tab)
vim.keymap.set("n", "<C-w>", ":bd<CR>", { noremap = true, silent = true })

-- Save and quit quickly
vim.keymap.set("n", "<C-S-q>", ":wq<CR>", { noremap = true, silent = true })

-- Select all (Ctrl + A)
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Toggle file explorer (if using nvim-tree)
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Next/Previous tab (buffer)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", "<Nop>", { noremap = true })

-----------------------------------------------------------
-- Window Navigation Remaps
-----------------------------------------------------------
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })  -- Move left
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })  -- Move right
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })  -- Move down
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })  -- Move up
