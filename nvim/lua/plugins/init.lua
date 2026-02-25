return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "rust_analyzer", "clangd" },
    },
  },

  {
    "m4xshen/smartcolumn.nvim",
    event = "BufReadPre",
    opts = {
      colorcolumn = "80",
      disabled_filetypes = { "help", "text", "markdown", "NvimTree", "lazy", "mason" },
      custom_colorcolumn = {
        rust = "100",
      },
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
