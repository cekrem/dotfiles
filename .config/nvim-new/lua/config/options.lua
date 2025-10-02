-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("colorscheme delek") -- solarized is not ready, but this theme is similar; avoids flashing
vim.opt.relativenumber = false
vim.opt.swapfile = false

-- make inlay hints dimmer
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

-- vlime settings
vim.g.vlime_enable_autodoc = true
