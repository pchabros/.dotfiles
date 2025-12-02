require("auto-session").setup({
  load_on_setup = true,
  auto_save_enabled = true,
  session_lens = {
    load_on_setup = true,
    theme_conf = { border = true },
  },
})

vim.keymap.set("n", "<leader>fs", ":Autosession search<CR>", {
  noremap = true,
  desc = "Find session",
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
