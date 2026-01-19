require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Find symbols in file" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Find symbols in project" })

map("n", "<leader>e", function()
  local nvimtree = require("nvim-tree.api")
  local current_buf = vim.api.nvim_get_current_buf()
  local current_buf_ft = vim.bo[current_buf].filetype

  if current_buf_ft == "NvimTree" then
    vim.cmd("wincmd p")
  else
    nvimtree.tree.focus()
  end
end, { desc = "Toggle nvim-tree focus" })
