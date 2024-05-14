require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.numberwidth = 4
opt.writebackup = false
opt.expandtab = true -- 将tab转换为空格
opt.cursorline = true -- 高亮当前行
opt.foldenable = false
opt.scrolloff = 4 -- vim滚动时保持光标距离屏幕上下边缘的行数
opt.fdm = "syntax"
opt.fileformats = "unix"
opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding