return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      local luasnip = require("luasnip")
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
