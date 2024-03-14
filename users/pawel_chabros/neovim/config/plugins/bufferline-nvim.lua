local bufferline = require("bufferline")

if vim.g.started_by_firenvim == true then
else
  bufferline.setup({
    options = {
      mode = "tabs",
      style_preset = bufferline.style_preset.minimal,
    },
  })
end
