-- Bootstrap: settings, plugins, then keymaps.
-- This file intentionally stays small — its only job is to load the
-- three top-level modules in the right order.

require("options")

vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")

require("plugins")
require("keymaps")
