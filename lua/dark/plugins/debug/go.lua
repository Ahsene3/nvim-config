local dap = require("dap")

-- Go debugging with Delve
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug Go File",
    request = "launch",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      local args = {}
      for arg in string.gmatch(args_string, "%S+") do
        table.insert(args, arg)
      end
      return args
    end,
  },
  {
    type = "delve",
    name = "Debug Go Package",
    request = "launch",
    program = "${workspaceFolder}",
  },
  {
    type = "delve",
    name = "Debug Test File",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug Test Package",
    request = "launch",
    mode = "test",
    program = "${workspaceFolder}",
  },
  {
    type = "delve",
    name = "Attach",
    mode = "local",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}
