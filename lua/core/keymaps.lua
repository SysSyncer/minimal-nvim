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

-----------------------------------------------------------
-- File Operations
-----------------------------------------------------------
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })        -- Save
vim.keymap.set("n", "<C-w>", ":close<CR>", { noremap = true, silent = true })    -- Close window
vim.keymap.set("n", "<C-S-q>", ":wqa<CR>", { noremap = true, silent = true })    -- Save and quit all

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

-----------------------------------------------------------
-- Window Splits
-----------------------------------------------------------
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })  -- Vertical split
vim.keymap.set("n", "<leader>s", ":split<CR>", { noremap = true, silent = true })   -- Horizontal split
