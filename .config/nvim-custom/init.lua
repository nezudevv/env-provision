--  NOTE: remaps and sets must happen before plugins are loaded (otherwise wrong leader will be used)
require("nezudevv")

vim.diagnostic.config({ virtual_text = true })
vim.o.termguicolors = true
vim.cmd("colorscheme kanagawa-dragon")
vim.opt.linespace = 10
