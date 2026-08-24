vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.laststatus = 3

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.grepprg = "rg --vimgrep --smart-case"

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = {
  tab = "  ",
  trail = ".",
  nbsp = "+",
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.filetype.add({
  extension = {
    env = "sh",
    mdx = "markdown",
  },
  filename = {
    [".env"] = "sh",
    [".env.local"] = "sh",
    [".gitignore"] = "gitignore",
  },
  pattern = {
    [".*/%.github/workflows/.*%.yml"] = "yaml",
    [".*/%.github/workflows/.*%.yaml"] = "yaml",
  },
})
