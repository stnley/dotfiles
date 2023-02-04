local has_dap, local_dap = pcall(require, "dap")
local has_dapui, local_dapui = pcall(require, "dapui")

local dap_go = require("dap-go")
local dap_python = require("dap-python")

if not has_dap or not has_dapui then
  return
end

local signs = {
  DapBreakpoint = {
    text = "B",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  DapBreakpointCondition = {
    text = "C",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  DapBreakpointRejected = {
    text = "R",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  DapLogPoint = {
    text = "L",
    texthl = "DiagnosticSignInfo",
    linehl = "",
    numhl = "",
  },
  DapStopped = {
    text = "→",
    texthl = "DiagnosticSignInfo",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "DiagnosticSignInfo",
  },
}

for sign, highlights in pairs(signs) do
  vim.fn.sign_define(sign, highlights)
end

local_dap.listeners.after.event_initialized["dapui_config"] = function()
  local_dapui.open({})
end

local_dap.listeners.before.event_terminated["dapui_config"] = function()
  local_dapui.close({})
end

local_dap.listeners.before.event_exited["dapui_config"] = function()
  local_dapui.close({})
end

-- debuggers
dap_go.setup({})

local venv = vim.fn.expand("$XDG_DATA_HOME") .. "/virtualenvs"
dap_python.setup(venv .. "/debugpy/bin/python")
