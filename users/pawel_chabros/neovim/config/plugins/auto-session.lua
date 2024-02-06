require("auto-session").setup({
  load_on_setup = true,
  auto_save_enabled = true,
  session_lens = {
    load_on_setup = true,
    theme_conf = { border = true },
  },
})

vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, {
  noremap = true,
  desc = "Find session",
})
