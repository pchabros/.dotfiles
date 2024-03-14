if vim.g.started_by_firenvim == true then
  vim.fn["firenvim#install"](0)
end

local always = {
  cmdline = "neovim",
  content = "html",
  selector = "textarea",
  takeover = "always",
  priority = 1,
}

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      takeover = "never",
    },
    ["github"] = always,
    ["mypy-play"] = always,
  },
}
