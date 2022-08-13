local options = {
  tabstop = 4,       -- Number of spaces that a <Tab> in the file counts for.
  shiftwidth = 2,    -- Number of spaces to use for each step of (auto)indent.
  expandtab = true,       -- Use the appropriate number of spaces to insert a <Tab>.
  smarttab = true,        -- When on, a <Tab> in front of a line inserts blanks
  showcmd = true,         -- Show (partial) command in status line.
  hlsearch = false,        -- When there is a previous search pattern, highlight all
  incsearch = true,       -- While typing a search command, show immediately where the
  ignorecase = true,      -- Ignore case in search patterns.
  smartcase = true,       -- Override the 'ignorecase' option if the search pattern
  smartindent = true,                      -- make indenting smarter again
  backspace = "2",     -- Influences the working of <BS>, <Del>, CTRL-W
  autoindent = true,      -- Copy indent from current line when starting a new line
  textwidth = 250,    -- Maximum width of text that is being inserted. A longer
  formatoptions = "cqrt", -- This is a sequence of letters which describes how
  ruler = true,           -- Show the line and column number of the cursor position,
  background = "dark", -- When set to "dark", Vim will try to use colors that look
  mouse = "a",         -- Enable the use of the mouse.
--  encoding = "utf-8",  -- Enforce UTF-8 encoding
  foldmethod = "marker",
  number = true,
  relativenumber = true,
  hidden = true,
  undodir = "~/.vim/undodir",
  undofile = true,
  scrolloff = 8,     -- start scrolling when the cursor reaches 8 lines from end
  signcolumn = "auto", -- auto show the sign column
  cursorline = true, -- Highlight the current cursor line
  cursorlineopt = "number",
  syntax = "on",
  autoread = true,
  termguicolors = true
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
