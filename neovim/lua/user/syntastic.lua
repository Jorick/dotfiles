-- Syntastic settings
vim.g.syntastic_javascript_checkers = "standard"
vim.g.syntastic_css_checkers = "csslint"
vim.g.syntastic_python_checkers = {"pylint"}

vim.cmd [[
  autocmd bufwritepost *.js silent !standard-format -w %
]]
