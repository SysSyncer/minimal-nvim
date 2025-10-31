🧱 Step 1 → Recommended Folder Structure

Here’s a clean structure for your Neovim config (~/.config/nvim/):

nvim/
├── init.lua                 <-- main entry file
├── lua/
│   ├── core/
│   │   ├── options.lua      <-- tab width, numbers, etc.
│   │   └── keymaps.lua      <-- Ctrl+S, Ctrl+H/L/J/K, etc.
│   ├── plugins/
│   │   ├── init.lua         <-- Lazy.nvim bootstrap & plugin list
│   │   ├── lsp.lua          <-- common LSP capabilities + setup
│   │   ├── java.lua         <-- JDTLS config
│   │   ├── python.lua       <-- Pyright config
│   │   └── ui.lua           <-- theme, lualine, bufferline, tree
│   └── utils.lua            <-- optional helper functions


⸻

🪄 Step 2 → Your init.lua (now super small)

-- Load core settings
require("core.options")
require("core.keymaps")

-- Load plugin system (Lazy)
require("plugins")

That’s it. 😎

⸻

⚙️ Step 3 → lua/core/options.lua

local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true


⸻

🎹 Step 4 → lua/core/keymaps.lua

vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save / Close
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts)
map("n", "<C-w>", ":bd<CR>", opts)
map("n", "<C-S-q>", ":wq<CR>", opts)

-- Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- Buffers
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Misc
map("n", "<C-a>", "ggVG", opts)
map("n", "<C-z>", "<Nop>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)


⸻

🧩 Step 5 → lua/plugins/init.lua

Here we bootstrap Lazy and then require other plugin modules:

vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "windwp/nvim-autopairs", config = true },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "projekt0n/github-nvim-theme", priority = 1000 },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "mfussenegger/nvim-jdtls", ft = { "java" } },
})

-- Load configurations
require("plugins.ui")
require("plugins.lsp")
require("plugins.java")
require("plugins.python")


⸻

🧠 Step 6 → lua/plugins/lsp.lua

Here you configure general LSP + nvim-cmp (works for all languages):

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim-cmp setup
cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Default capabilities for all LSPs
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  { capabilities = capabilities }
)


⸻

☕ Step 7 → lua/plugins/java.lua

Keep your existing JDTLS setup here (exactly as before).

⸻

🐍 Step 8 → lua/plugins/python.lua

Here’s your Pyright setup:

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    -- Auto format on save (optional)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "lua vim.lsp.buf.format()",
    })
  end,
})


⸻

🎨 Step 9 → lua/plugins/ui.lua

Theme, lualine, file tree, and bufferline live here:

-- Theme
require("github-theme").setup({
  options = { theme_style = "dimmed", transparent = false },
})
vim.cmd("colorscheme github_dark_dimmed")

-- Lualine
require("lualine").setup({
  options = { theme = "github_dark_dimmed", globalstatus = true },
})

-- NvimTree
require("nvim-tree").setup({ view = { side = "right", width = 35 } })

-- Bufferline
require("bufferline").setup({
  options = { diagnostics = "nvim_lsp", separator_style = "slant" },
})


⸻

✅ Step 10 → Result

After you move your existing code into these files:
	•	You’ll still have everything you already built (Java, autocomplete, theme, etc.)
	•	And now you’ll also get Python LSP with proper autocompletion and formatting
	•	Plus your config will be modular, easy to extend to other languages later (C#, Go, JS, etc.)

