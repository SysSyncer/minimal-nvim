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
  -- Theme
  -----------------------------------------------------------
  { 
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          -- Available styles: "dark", "dimmed", "light", "dark_default"
          theme_style = "dark",
          transparent = false,
          dim_inactive = true,
          module_default = true,
        },
      })
      -- Use vim.schedule to ensure theme is loaded before setting colorscheme
      vim.schedule(function()
        -- Try to set colorscheme with error handling
        local status, err = pcall(function()
          vim.cmd("colorscheme github_dark_tritanopia")
        end)
        if not status then
          vim.notify("Failed to load colorscheme: " .. tostring(err), vim.log.levels.WARN)
          -- Fallback to default
          vim.cmd("colorscheme default")
        end
      end)
    end,
  },

  -- lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "github_dark_dimmed",
          icons_enabled = true,
          section_separators = { left = '|', right = '|' },
          component_separators = { left = '|', right = '|' },
          globalstatus = true,
        },
      })
    end,
  },

  -----------------------------------------------------------
  -- Java LSP (loads only for Java)
  -----------------------------------------------------------
  -- JDTLS is now configured with vim.lsp.config (see below)
  -- No need for the nvim-jdtls plugin anymore, just use lspconfig approach

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

  -----------------------------------------------------------
  -- Python LSP, Formatting & Linting
  -----------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    ft = { "python" },
    config = function()
      local lint = require("lint")
      
      -- Only enable linters that are available
      local available_linters = {}
      for _, linter in ipairs({ "pylint", "flake8" }) do
        if vim.fn.executable(linter) == 1 then
          table.insert(available_linters, linter)
        end
      end
      
      lint.linters_by_ft = {
        python = available_linters,
      }
      
      -- Only set up auto-linting if we have linters available
      if #available_linters > 0 then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = "*.py",
          callback = function()
            lint.try_lint()
          end,
        })
      else
        vim.notify("No Python linters found. Install with: pip install pylint flake8", vim.log.levels.WARN)
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    ft = { "python" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black", "isort" },
        },
        -- Use LSP formatting as fallback if formatters not available
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        -- Suppress errors from missing formatters
        formatters = {
          black = {
            -- Don't error if black is not found
            condition = function()
              return vim.fn.executable("black") == 1
            end,
          },
          isort = {
            -- Don't error if isort is not found
            condition = function()
              return vim.fn.executable("isort") == 1
            end,
          },
        },
      })
    end,
  },

  -----------------------------------------------------------
  -- JavaScript/TypeScript Formatting & Linting
  -----------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      local lint = require("lint")
      
      local available_linters = {}
      for _, linter in ipairs({ "eslint" }) do
        if vim.fn.executable(linter) == 1 then
          table.insert(available_linters, linter)
        end
      end
      
      lint.linters_by_ft = {
        javascript = available_linters,
        typescript = available_linters,
        javascriptreact = available_linters,
        typescriptreact = available_linters,
      }
      
      if #available_linters > 0 then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
          callback = function()
            lint.try_lint()
          end,
        })
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          prettier = {
            condition = function()
              return vim.fn.executable("prettier") == 1
            end,
          },
        },
      })
    end,
  },

  -----------------------------------------------------------
  -- Go Formatting & Linting
  -----------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    ft = { "go" },
    config = function()
      local lint = require("lint")
      
      local available_linters = {}
      for _, linter in ipairs({ "golangci-lint" }) do
        if vim.fn.executable(linter) == 1 then
          table.insert(available_linters, linter)
        end
      end
      
      lint.linters_by_ft = {
        go = available_linters,
      }
      
      if #available_linters > 0 then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = "*.go",
          callback = function()
            lint.try_lint()
          end,
        })
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    ft = { "go" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports", "gofmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          goimports = {
            condition = function()
              return vim.fn.executable("goimports") == 1
            end,
          },
          gofmt = {
            condition = function()
              return vim.fn.executable("gofmt") == 1
            end,
          },
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

-----------------------------------------------------------
-- Python LSP Configuration (Neovim 0.11+ with vim.lsp.config)
-----------------------------------------------------------
-- Pyright (Microsoft's Python LSP)
vim.lsp.config("pyright", {
  cmd = { 
    vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver",
    "--stdio"
  },
  root_markers = { "pyrightconfig.json", "pyproject.toml", ".git", ".venv" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Auto-start LSP servers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function(args)
    vim.lsp.enable("pyright")
  end,
})

-----------------------------------------------------------
-- JavaScript/TypeScript LSP Configuration
-----------------------------------------------------------
vim.lsp.config("ts_ls", {
  cmd = { 
    vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server",
    "--stdio"
  },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "literal",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

-- Auto-start for TypeScript/JavaScript
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  callback = function(args)
    vim.lsp.enable("ts_ls")
  end,
})

-----------------------------------------------------------
-- Go LSP Configuration
-----------------------------------------------------------
vim.lsp.config("gopls", {
  cmd = { 
    vim.fn.stdpath("data") .. "/mason/bin/gopls"
  },
  root_markers = { "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- Auto-start for Go
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function(args)
    vim.lsp.enable("gopls")
  end,
})

-----------------------------------------------------------
-- Java LSP Configuration (Neovim 0.11+ with vim.lsp.config)
-----------------------------------------------------------
vim.lsp.config("jdtls", {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
  root_markers = { ".git", "mvnw", "gradlew", "pom.xml" },
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
    },
  },
})

-- Auto-start JDTLS for Java files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function(args)
    vim.lsp.enable("jdtls")
  end,
})

-----------------------------------------------------------
-- Global LSP Keymaps (works for all languages)
-----------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { noremap = true, silent = true, buffer = event.buf }
    
    -- Hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    
    -- Go to references
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    
    -- Rename symbol
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    
    -- Code actions
    vim.keymap.set("n", "<C-A-l>", vim.lsp.buf.code_action, opts)
    
    -- Format document
    vim.keymap.set("n", "<C-S-f>", function()
      require("conform").format({ lsp_fallback = true })
    end, opts)
    
    -- Signature help
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    
    -- Go to declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  end,
})
