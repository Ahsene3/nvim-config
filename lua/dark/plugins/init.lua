return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  "nvim-neotest/nvim-nio", -- Required for nvim-dap-ui
  "mfussenegger/nvim-dap", -- Debug Adapter Protocol for debugging
  "rcarriga/nvim-dap-ui", -- UI for nvim-dap
  "github/copilot.vim", -- GitHub Copilot plugin

  -- LSP and Completion Plugins
  { "neovim/nvim-lspconfig" }, -- LSP support
  { "hrsh7th/nvim-cmp" }, -- Auto-completion
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP completion source
  { "hrsh7th/cmp-buffer" }, -- Buffer completions
  { "hrsh7th/cmp-path" }, -- Path completions
  { "L3MON4D3/LuaSnip" }, -- Snippet engine
  { "saadparwaiz1/cmp_luasnip" }, -- Luasnip completion source
  { "rafamadriz/friendly-snippets" }, -- Collection of snippets
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Syntax highlighting

  -- Mason Plugin for managing LSP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Other LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
}
