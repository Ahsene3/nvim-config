return {
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_shell = "/bin/zsh" -- Or "/bin/bash"
      vim.api.nvim_set_keymap("n", "<leader>t", ":FloatermToggle<CR>", { noremap = true, silent = true })
    end,
  },
}
