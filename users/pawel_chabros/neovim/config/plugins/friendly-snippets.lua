local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("typescript", { "angular" })
luasnip.filetype_extend("html", { "angular" })
luasnip.filetype_extend("python", { "django", "django-rest" })
