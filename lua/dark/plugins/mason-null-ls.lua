return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Formatters
        "clang_format", -- C/C++
        "prettier", -- JS, TS, HTML, CSS
        "rustfmt", -- Rust
        "gofmt", -- Go

        -- Linters
        "cpplint", -- C++
        "eslint_d", -- JS, TS
        "flake8", -- Python
        "shellcheck", -- Shell scripts
        "markdownlint", -- Markdown
        "luacheck", -- Lua
        "golangci-lint", -- Go
        "clippy", -- Rust
      },
      automatic_installation = true,
    })
  end,
}
