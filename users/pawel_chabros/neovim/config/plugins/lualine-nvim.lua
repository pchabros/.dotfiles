require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
  },
  -- sections = {
  --   lualine_a = {
  --     {
  --       'mode',
  --       separator = { left = '', right = '' },
  --     }
  --   },
  --   lualine_z = {
  --     {
  --       'location',
  --       separator = { left = '', right = '' },
  --     }
  --   },
  -- }
  inactive_sections = {
    lualine_a = { "branch" },
  },
})
