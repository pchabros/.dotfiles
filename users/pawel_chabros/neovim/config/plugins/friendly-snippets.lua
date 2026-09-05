local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load({
  exclude = { "terraform" },
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})

luasnip.filetype_extend("typescript", { "typescriptreact" })
luasnip.filetype_extend("typescript", { "html" })
luasnip.filetype_extend("html", { "angular" })
luasnip.filetype_extend("python", { "django", "django-rest" })
