return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Enable DAP logging
      vim.g.dap_log_level = "DEBUG"
      vim.fn.mkdir(vim.fn.stdpath("cache") .. "/dap_logs", "p")
      --require("dap").set_log_file(vim.fn.stdpath("cache") .. "/dap_logs/dap.log")

      -- DAP UI Setup
      dapui.setup()

      -- Virtual text for DAP (shows variable values inline)
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
      })

      -- Open and close dapui automatically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Debug Keybindings
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dl", function()
        require("dap").run_last()
      end, { desc = "Run Last Debug Configuration" })
      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { desc = "Toggle Debug UI" })
      vim.keymap.set("n", "<leader>dx", function()
        dap.terminate()
      end, { desc = "Terminate Debug Session" })

      -- Log file shortcut
      vim.keymap.set("n", "<leader>dL", function()
        vim.cmd("edit " .. vim.fn.stdpath("cache") .. "/dap_logs/dap.log")
      end, { desc = "Open DAP Log" })

      -- Load language-specific setups
      --require("dark.plugins.debug.cpp") -- C/C++
      --require("dark.plugins.debug.rust") -- Rust
      require("dark.plugins.debug.go") -- Go
      require("dark.plugins.debug.python") -- python
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "delve" }, -- Debuggers for C/C++/Rust and Go
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
}
