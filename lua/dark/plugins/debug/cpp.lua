local dap = require("dap")
-- Setup codelldb for C/C++
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/Users/ahsenali/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
    args = { "--port", "${port}" },
  },
}

-- Add cpptools adapter
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/Users/ahsenali/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch C/C++ (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    },
  },
  {
    name = "Attach to process (codelldb)",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
    cwd = "${workspaceFolder}",
  },
  -- Add cpptools configurations
  {
    name = "Launch C/C++ (cppdbg)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
  {
    name = "Attach to gdbserver (cppdbg)",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
}

-- Use the same configurations for C
dap.configurations.c = dap.configurations.cpp

-- Set up custom capabilities for clangd to fix offset encoding
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

-- Configure clangd with proper capabilities
require("lspconfig").clangd.setup({
  capabilities = capabilities,
})

-- Add the hover keybinding for C/C++ buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
  end,
})
