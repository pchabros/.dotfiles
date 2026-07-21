local install_parser_and_enable_features = function(event)
  local lang = event.match
  local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
  if not ok then return end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('ui.treesitter', { clear = true }),
  pattern = { '*' },
  callback = install_parser_and_enable_features
})
