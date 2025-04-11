return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200

    -- Additional cursor performance settings
    vim.o.ttimeoutlen = 10 -- Very short timeout for key code sequences
    vim.o.updatetime = 200 -- Faster cursor updates for plugins
    vim.o.ttyfast = true -- Faster terminal connection
    vim.o.cursorline = true
    vim.o.scrolloff = 10 -- keep more context visible
    vim.o.sidescrolloff = 10
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
