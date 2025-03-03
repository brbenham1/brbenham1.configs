-- [[ Mapping local leader ]]
-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- [[ Basic Keymaps ]]
-- See ':help vim.keymap.set()'

-- Clear highlights on search when pressing
-- See ':help hlsearch'
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>',   '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>',  '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>',     '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>',   '<cmd>echo "Use j to move!!"<CR>')

-- Keybind to make split navigation easier.
-- Use CTRL + <hjkl> to switch between windows
--
-- See ':help wincmd' for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = "Move focus to the left window" })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = "Move focus to the right window" })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = "Move focus to the upper window" })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = "Move focus to the left window" })

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

-- [[ Install 'lazy.nvim' plugin manager ]]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
-- To check the current status of your plugins, run
--  :Lazy
--
-- You can press '?' in this menu for help. Use ':q' to close the window
--
-- To update plugins you can run
--  :Lazy update
--
--  Install plugins below...
require("lazy").setup({
    "rebelot/kanagawa.nvim"
})

vim.cmd.colorscheme("kanagawa-wave")

