local dap = require("dap")

-- Node.js adapter
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

-- JavaScript Debug Terminal
dap.adapters.javascript = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

-- Debug adapters for Chrome, Firefox, and Edge
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
}

-- JavaScript configurations
dap.configurations.javascript = {
  {
    name = "Launch Node.js",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to Node.js process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
  {
    name = "Launch Chrome",
    type = "chrome",
    request = "launch",
    url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({
          prompt = "Enter URL: ",
          default = "http://localhost:3000",
        }, function(url)
          if url then
            coroutine.resume(co, url)
          else
            coroutine.resume(co, "http://localhost:3000")
          end
        end)
      end)
    end,
    webRoot = "${workspaceFolder}",
    userDataDir = false,
    sourceMapPathOverrides = {
      ["webpack:///./~/*"] = "${webRoot}/node_modules/*",
      ["webpack:///./*"] = "${webRoot}/*",
      ["webpack:///*"] = "*",
    },
  },
  {
    name = "Attach to Chrome",
    type = "chrome",
    request = "attach",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
  {
    name = "Launch Firefox",
    type = "firefox",
    request = "launch",
    reAttach = false,
    url = function()
      return vim.fn.input("URL: ", "http://localhost:3000", "file")
    end,
    webRoot = "${workspaceFolder}",
    firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
  },
  {
    name = "Debug with JavaScript Debug Terminal",
    type = "javascript",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

-- Use the same configurations for TypeScript and React
dap.configurations.typescript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript

-- Add LSP configuration for JavaScript
require("lspconfig").tsserver.setup({
  -- TypeScript server setup
})

-- Add the hover keybinding for JavaScript buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
  end,
})

-- Custom keymappings for debugging
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>db", function()
      require("dap").toggle_breakpoint()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>dc", function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { buffer = bufnr })

    vim.keymap.set("n", "<Leader>dx", function()
      require("dap").termiante()
    end, { buffer = bufnr }) -- Close debugger with <Leader>dx
  end,
})
