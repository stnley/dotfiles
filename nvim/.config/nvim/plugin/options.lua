vim.opt.wildignore = {
  "*.o",
  "*.a",
  "__pycache__",
  "*.pyc",
  "*pycache*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/.git/*",
}

vim.o.guicursor = ""
vim.o.cursorline = true
vim.o.hlsearch = false
vim.o.number = true -- show actual number of current line
vim.o.relativenumber = true -- show relative line numbers
vim.o.scrolloff = 8

vim.o.signcolumn = "yes"
vim.o.splitright = true -- prefer windows split to right
vim.o.splitbelow = true -- prefer windows split to bottom

vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.cmdheight = 1

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.wrap = false
vim.o.clipboard = "unnamedplus"

vim.o.backup = false
vim.o.undodir = os.getenv("XDG_CACHE_HOME") .. "/.nvim/undodir"
vim.o.undofile = true
vim.o.swapfile = false
vim.o.updatetime = 250

vim.o.mouse = "n"

-- default: "menu,preview"
vim.o.completeopt = "menuone,noselect"

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
