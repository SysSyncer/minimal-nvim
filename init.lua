-----------------------------------------------------------
-- Lazy.nvim bootstrap (plugin manager)
-----------------------------------------------------------
vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -----------------------------------------------------------
  -- Core Plugins
  -----------------------------------------------------------
  { "williamboman/mason.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -----------------------------------------------------------
  -- Completion Plugins
  -----------------------------------------------------------
  { "hrsh7th/nvim-cmp" },             -- Completion engine
  { "hrsh7th/cmp-nvim-lsp" },         -- LSP source for nvim-cmp
  { "hrsh7th/cmp-buffer" },           -- Buffer words
  { "hrsh7th/cmp-path" },             -- Filesystem paths
  { "L3MON4D3/LuaSnip" },             -- Snippet engine
  { "saadparwaiz1/cmp_luasnip" },     -- Snippet completions

  -----------------------------------------------------------
  -- Java LSP (loads only for Java)
  -----------------------------------------------------------
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      -- Project root
      local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
      if not root_dir then
        print("No Java project root found, skipping JDTLS start.")
        return
      end

      -- Workspace per project
      local workspace_folder = vim.fn.stdpath("data") ..
        "/jdtls-workspace/" ..
        vim.fn.fnamemodify(root_dir, ":p:h:t")

      -- JDTLS binary from Mason
      local cmd = {
        vim.fn.stdpath("data") .. "/mason/bin/jdtls",
        "-data", workspace_folder,
      }

      print("Starting JDTLS from: " .. cmd[1])

      jdtls.start_or_attach({
        cmd = cmd,
        root_dir = root_dir,
        settings = { java = {} },
        init_options = {},
      })
    end,
  },

  -----------------------------------------------------------
  -- nvim-tree File Tree
  -----------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right",      -- show on the right side
          width = 35,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      -- Toggle with Ctrl + b
      vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -----------------------------------------------------------
  -- akinsho/bufferline (Tabs)
  -----------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        },
      })
    end,
  },
})


-----------------------------------------------------------
-- nvim-cmp Setup (Autocompletion)
-----------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),   -- Trigger completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
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

-----------------------------------------------------------
-- LSP Capabilities (connect nvim-cmp with LSP)
-----------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- Add default capabilities for any other LSPs (optional)
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  { capabilities = capabilities }
)

-----------------------------------------------------------
-- Basic Editor Settings
-----------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes" -- Always show gutter for LSP signs

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true })  -- delete previous word in insert mode
vim.keymap.set("n", "<A-BS>", "db", { noremap = true })     -- delete previous word in normal mode
