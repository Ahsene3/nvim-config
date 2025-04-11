return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local rt = require("rust-tools")
    local dap = require("dap")
    local dapui = require("dapui")

    -- Adapter setup for codelldb
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- Rust configuration
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        --args = function()
        --local input = vim.fn.input("Arguments: ")
        --return vim.fn.split(input, " ", true)
        -- end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = false,
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }

    -- UI setup
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

    -- Setup rust-tools
    rt.setup({
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        on_attach = function(_, bufnr)
          -- Keep <leader>ha as pure hover
          vim.keymap.set(
            "n",
            "<Leader>ha",
            rt.hover_actions.hover_actions,
            { buffer = bufnr, desc = "Rust Hover Actions" }
          )

          -- Debug keymaps for Rust only
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
      dap = {
        adapter = dap.adapters.codelldb,
        configuration = dap.configurations.rust, -- Add this line
        cargoExtraArgs = { "--release", "--features=some_feature" },
      },
    })
  end,
}
