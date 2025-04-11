return {
  "github/copilot.vim",
  config = function()
    -- Prevent Copilot from starting automatically
    vim.g.copilot_enabled = false

    -- Don't let Copilot map any keys
    vim.g.copilot_assume_mapped = true

    -- Disable Copilot in all filetypes by default
    vim.g.copilot_filetypes = {
      ["*"] = true,
    }

    -- Only apply Copilot suggestion highlight after it's explicitly enabled
    vim.api.nvim_create_autocmd("User", {
      pattern = "CopilotEnabled",
      callback = function()
        vim.cmd([[highlight CopilotSuggestion ctermfg=8 guifg=white guibg=#5c6370]])
      end,
    })
  end,
}
