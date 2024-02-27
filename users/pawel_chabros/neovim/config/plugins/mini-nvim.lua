require("mini.ai").setup({
  custom_textobjects = {
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
  },
})
