-- [[ Setting options ]]
-- For more options see ':help vim.opt'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_fonts = true

-- Make line numbers default
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Do not wrap lines
vim.opt.wrap = false

-- Sync clipboard between OS and NeoVim.
-- Schedule the setting after 'UiEnter' because it can increase startup-time.
vim.schedule(function() 
    vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one more captial letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 999

-- Set to gui color to terminal
vim.opt.termguicolors = true

-- Expand <Tab> to spaces in Insert mode
vim.opt.expandtab = true

-- Number of spaces a <Tab> in the text stands for
vim.opt.tabstop = 4

-- Number of spaces used for each step of (auto)indent
vim.opt.shiftwidth = 4

-- Allow virtual editing in Visual block mode.
vim.opt.virtualedit = 'block'

-- [[ Basic Autocommands ]]
-- See ':help lua-guide-autocommands'
--
-- Highlight when yanking (copying) text
--  Try it with 'yap' in normal mode
--  See ':help vim.highlight.on_yank()'
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
