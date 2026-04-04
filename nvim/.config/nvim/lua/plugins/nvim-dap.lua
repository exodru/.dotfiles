return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- UI components
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    -- Installs the Go-specific DAP configurations automatically
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. Setup DAP UI
    dapui.setup()

    -- Automatically open and close the UI when debugging starts/stops
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- 2. Setup Golang
    -- This automatically configures dlv (delve) for Go
    require("dap-go").setup()

    -- 3. Setup C/C++
    -- We are using codelldb, which is the standard LLVM debugger adapter.
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        -- This path assumes you installed codelldb via Mason.
        -- If installed manually, change this to the absolute path of the codelldb executable.
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        -- Prompts you for the path to the compiled binary before debugging
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- C utilizes the exact same configuration as C++
    dap.configurations.c = dap.configurations.cpp
  end,
}
