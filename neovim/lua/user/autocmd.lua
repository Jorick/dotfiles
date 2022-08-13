-- Vim auto commands
-- Markdown
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufReadPost"}, {
    pattern = { "*.md"},
    command = [[filetype=markdown]],
  }
)

-- Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
