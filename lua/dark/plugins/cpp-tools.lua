return {
  "p00f/clangd_extensions.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    -- Add your DAP setup code here
    local dap = require("dap")
    local dapui = require("dapui")
    local clangd_ext = require("clangd_extensions")

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

    -- Add clangd_extensions setup here
    clangd_ext.setup({
      server = {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })

          -- Debug keymaps for C/C++ only
          vim.keymap.set("n", "<F5>", dap.continue, { buffer = bufnr, desc = "Start/Continue Debugging" })
          vim.keymap.set("n", "<F10>", dap.step_over, { buffer = bufnr, desc = "Step Over" })
          vim.keymap.set("n", "<F11>", dap.step_into, { buffer = bufnr, desc = "Step Into" })
          vim.keymap.set("n", "<F12>", dap.step_out, { buffer = bufnr, desc = "Step Out" })
          vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { buffer = bufnr, desc = "Toggle Breakpoint" })
          vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end, { buffer = bufnr, desc = "Set Conditional Breakpoint" })
          vim.keymap.set("n", "<leader>dr", dap.repl.open, { buffer = bufnr, desc = "Open REPL" })
          vim.keymap.set("n", "<leader>dl", dap.run_last, { buffer = bufnr, desc = "Run Last Debug" })
          vim.keymap.set("n", "<leader>du", dapui.toggle, { buffer = bufnr, desc = "Toggle Debug UI" })
          vim.keymap.set("n", "<leader>dx", dap.terminate, { buffer = bufnr, desc = "Terminate Debug" })
          vim.keymap.set("n", "<leader>dL", function()
            vim.cmd("edit " .. vim.fn.stdpath("cache") .. "/dap_logs/dap.log")
          end, { buffer = bufnr, desc = "Open DAP Log" })
        end,
      },
      extensions = {
        hover = {
          enabled = true,
          auto_focus = true,
          show_static = true, -- Show hover even for static items
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
        },
        inlay_hints = {
          enabled = true,
        },
        ast = {
          enabled = true,
        },
        memory_usage = {
          enabled = true,
        },
        symbol_info = {
          enabled = true,
        },
      },
    })

    -- Setup DAP UI
    dapui.setup()
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
