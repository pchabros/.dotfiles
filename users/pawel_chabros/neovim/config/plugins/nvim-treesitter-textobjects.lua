require("nvim-treesitter.config").setup({
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]c"] = "@class.outer",
        ["]f"] = "@function.outer",
      },
      goto_previous_start = {
        ["[c"] = "@class.outer",
        ["[f"] = "@function.outer",
      },
    },
  },
})
