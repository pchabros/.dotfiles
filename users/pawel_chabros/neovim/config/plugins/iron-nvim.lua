local iron = require("iron.core")

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = {
        command = { "zsh" },
      },
      python = {
        command = "ipython",
        format = require("iron.fts.common").bracketed_paste,
      },
    },
    repl_open_cmd = require("iron.view").right(120),
  },
  keymaps = {
    send_motion = "<space>ss",
    visual_send = "<space>ss",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>sl",
  },
  highlight = {
    bold = false,
  },
  ignore_blank_lines = true,
})

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
