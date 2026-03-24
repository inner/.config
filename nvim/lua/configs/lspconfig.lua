require("nvchad.configs.lspconfig").defaults()

-- Get capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure rust-analyzer with proper settings
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

local servers = { "rust_analyzer", "clangd", "gopls", "pyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
