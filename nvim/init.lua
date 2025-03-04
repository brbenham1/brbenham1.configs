-- [[ Mapping local leader ]]
-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Load Core Configurations ]]
require("options")	    -- General Neovim settings and options
require("keymaps")      -- Key mappings
-- require("autocmds")     -- Load custom autocommands

require("config.lazy")  -- Load lazy
