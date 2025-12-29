-- Enable mason with mason-lsp-config
require("mason-lspconfig").setup()

-- Enable language configs:
-- Python
--vim.lsp.enable('python-lsp-server')
-- Javascript and Typescript
--vim.lsp.enable('tsserver')
-- HTML
-- CSS
--Enable (broadcasting) snippet capability for completion
-- Theme check
-- Vim script
--vim.lsp.enable('vimls')
-- LUA
-- require('lspconfig')['sumneko_lua'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--}
-- JSON
--vim.lsp.enable('jsonls')
-- YAML
--vim.lsp.enable('yamlls')
-- Haskell
vim.lsp.config('hls', {
  cmd = {'haskell-language-server-wrapper', '--lsp'},
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

vim.lsp.enable('hls')
