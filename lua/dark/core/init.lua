require("dark.core.options")
require("dark.core.keymaps")
--require("dark.core.filetypes")

-- Add this block
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
