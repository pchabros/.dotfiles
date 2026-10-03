vim.g.no_man_maps = 1

require("man_nvim").setup({ picker = "telescope" })

vim.keymap.set("n", "<leader>fm", function()
  require("man_nvim").picker()
end, { desc = "Man pages" })
