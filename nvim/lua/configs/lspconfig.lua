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

local servers = { "rust_analyzer", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
