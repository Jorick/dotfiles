-- Airline options
vim.g.airline_theme = "gruvbox"
vim.g.airline_powerline_fonts = 0
local gset = vim.api.nvim_set_var
gset("airline#extensions#tabline#enabled", 1)
gset("airline#extensions#tabline#left_sep", "")
