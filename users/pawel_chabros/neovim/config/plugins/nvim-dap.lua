local dap = require('dap')
local dap_python = require('dap-python')
local dapui = require("dapui")
local wk = require("which-key")
local set = vim.keymap.set

vim.env.DJANGO_SETTINGS_MODULE = "app.settings"
vim.env.DEBUG = "1"

vim.fn.sign_define('DapBreakpoint', {
  text = '',
  texthl = 'ErrorMsg',
  linehl = '',
  numhl = 'ErrorMsg'
})

vim.fn.sign_define('DapBreakpointCondition', {
  text = '',
  texthl = 'ErrorMsg',
  linehl = '',
  numhl = 'SpellBad'
})

local set_python_dap = function()
  dap_python.setup('python')
  dap.configurations.python = {
    {
      type = 'debugpy',
      request = 'launch',
      name = 'Django',
      program = '${workspaceFolder}/manage.py',
      args = {
        'runserver',
      },
      justMyCode = true,
      django = true,
      console = "integratedTerminal",
    },
    {
      type = 'python',
      request = 'launch',
      name = "Launch file",
      program = "${file}",
    },
    {
      type = 'python',
      request = 'attach',
      name = 'Attach remote',
      connect = function()
        return {
          host = 'localhost',
          port = 5678
        }
      end,
    },
  }
end

set_python_dap()

vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
  callback = function() set_python_dap() end,
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.open()
end

dapui.setup()

wk.register({ d = { name = "Debug" } }, { prefix = "<leader>d" })

set("n", "<leader>db", dap.toggle_breakpoint, { desc = " Breakpoint" })
set("n", "<leader>dc", dap.continue, { desc = " Continue" })
set("n", "<leader>df", dap_python.test_method, { desc = "Test method" })
set("n", "<leader>du", dapui.toggle, { desc = "UI" })
set('n', '<leader>dd', dap.clear_breakpoints, { desc = "Clear breakpoints" })
set('n', '<leader>dr', dap.restart, { desc = "󰜉 Restart" })
set('n', '<leader>d;', dap.step_over, { desc = " Step over" })
set('n', '<leader>dk', dap.step_into, { desc = " Step into" })
set('n', '<leader>dl', dap.step_out, { desc = " Step out" })
