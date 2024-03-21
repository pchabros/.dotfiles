require("mini.bufremove").setup()

vim.keymap.set({ "n" }, "Q", MiniBufremove.delete)
