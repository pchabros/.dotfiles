local neotest = require("neotest")
local set = vim.keymap.set

neotest.setup({
  ...,
  adapters = {
    require("neotest-python")({
      env = { DJANGO_SETTINGS_MODULE = "app.settings" },
      dap = { justMyCode = false },
      runner = "django",
    }),
    require("neotest-jest")({
      jestCommand = function()
        return require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch"
      end,
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})

set("n", "<leader>tt", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run File" })

set("n", "<leader>tT", function()
  neotest.run.run(vim.loop.cwd())
end, { desc = "Run All Test Files" })

set("n", "<leader>tr", function()
  neotest.run.run()
end, { desc = "Run Nearest" })

set("n", "<leader>tl", function()
  neotest.run.run_last()
end, { desc = "Run Last" })

set("n", "<leader>ts", function()
  neotest.summary.toggle()
end, { desc = "Toggle Summary" })

set("n", "<leader>to", function()
  neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Show Output" })

set("n", "<leader>tO", function()
  neotest.output_panel.toggle()
end, { desc = "Toggle Output Panel" })

set("n", "<leader>tS", function()
  neotest.run.stop()
end, { desc = "Stop" })
