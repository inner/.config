local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    python = { "ruff_format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
