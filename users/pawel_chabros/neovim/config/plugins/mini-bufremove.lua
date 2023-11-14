require("mini.bufremove").setup()

vim.keymap.set({ "n" }, "q", MiniBufremove.delete)
