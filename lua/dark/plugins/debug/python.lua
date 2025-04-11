-- ~/.config/nvim/lua/dark/plugins/debug/python.lua
local dap = require("dap")

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      -- Detect Python path from active virtual environment if possible
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
      end

      -- Try using pyenv if available
      local handle = io.popen("which python3")
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
          return result:gsub("\n", "")
        end
      end

      -- Fallback to system Python
      return "/usr/bin/python3"
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch with arguments",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      local args = {}
      for arg in string.gmatch(args_string, "%S+") do
        table.insert(args, arg)
      end
      return args
    end,
    pythonPath = function()
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to process",
    processId = require("dap.utils").pick_process,
    pythonPath = function()
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Django",
    program = "${workspaceFolder}/manage.py",
    args = { "runserver", "--noreload" },
    pythonPath = function()
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
}

-- Make sure the Python debug adapter is installed
require("dap").adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

return dap.configurations.python
