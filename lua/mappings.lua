require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local umap = vim.api.nvim_del_keymap
local api = require "Comment.api"

-- unmap keys
umap("n", "<leader>cc")
-- umap("n", "gr")
-- umap("n", "gd")

-- basic
map({ "n", "v" }, "H", "^", { silent = true })
map({ "n", "v" }, "L", "$", { silent = true })
map("i", "jj", "<ESC>", { silent = true })
map("i", "jk", "<ESC>:w<CR>", { silent = true })
map("n", "q", ":q<CR>", { silent = true })
map("n", ",ts", function()
    require("scratch").scratch()
end)
map("n", ",fs", function()
    require("scratch").fzfScratch()
end)
map("n", ",m", function()
    require("scratch").scratchWithName()
end)
map("n", ",o", function()
    require("scratch").openScratch()
end)
map("n", "<C-\\>", ":%s/\\//g<CR>", { silent = true })
map({ "n" }, "<leader>cc", api.toggle.linewise.current, { desc = "toggle current line comment" })

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
vim.keymap.set("x", "<leader>cc", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked "toggle.linewise" (vim.fn.visualmode())
end)
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>:w<CR>")
-- vim.api.nvim_set_keymap('n', '<leader>u', ':set fileformat=unix<CR>', { noremap = true, silent = true })
map({ "n", "i", "v" }, "<C-s>", "<cmd>silent! set fileformat=unix | w <cr>")

map("n", "<leader>tb", "<cmd> TagbarToggle <CR>", { desc = "toggle tagbar" })
map("n", "<leader>w", "<cmd> HopWord <CR>", { desc = "toggle tagbar" })
map("n", "f", "<cmd> HopChar1CurrentLineAC <CR>", { desc = "find after" })
map("n", "F", "<cmd> HopChar1CurrentLineBC <CR>", { desc = "find before" })
map("n", "za", "<cmd> HopChar2 <CR>", { desc = "find anywhere" })
map("n", "zs", "<cmd> HopChar1 <CR>", { desc = "find anywhere" })
map("n", "gl", "<cmd> LspRestart <CR>", { desc = "restart lsp" })
map("n", "<leader>d", "<cmd> Git diff <CR>", { desc = "git diff" })
map("n", "<leader>tr", "<cmd> TroubleToggle <CR>", { desc = "trouble" })
map("n", "<leader>ts", "<cmd> Scratch <CR>", { desc = "scratch" })
map("n", "<leader>fs", "<cmd> ScratchOpenFzf <CR>", { desc = "scratch" })

map("v", "f", "<cmd> HopChar1CurrentLineAC <CR>", { desc = "find after" })
map("v", "F", "<cmd> HopChar1CurrentLineBC <CR>", { desc = "find before" })

map("i", "<C-b>", "<Left>", { desc = "move left" })
map("i", "<C-f>", "<Right>", { desc = "move right" })
map("i", "<C-p>", "<Up>", { desc = "move up" })
map("i", "<C-n>", "<Down>", { desc = "move down" })
map("i", "<C-h>", "<ESC>^i", { desc = "beginning of line" })
map("i", "<C-l>", "<End>", { desc = "end of line" })

-- telescope
map("n", "<C-p>", "<cmd> Telescope find_files <CR>", { desc = "  find files" })
map(
    "n",
    "<leader>fa",
    "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
    { desc = "  find all" }
)
map("n", "<leader>g", "<cmd> Telescope live_grep <CR>", { desc = "   live grep" })
map("n", "<leader>a", "<cmd> Telescope grep_string <CR>", { desc = "   grep string" })
map("n", "<C-b>", "<cmd> Telescope buffers <CR>", { desc = "  find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "  help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "   find oldfiles" })
map("n", "<leader>tk", "<cmd> Telescope keymaps <CR>", { desc = "   show keys" })

map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "   git commits" })
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "  git status" })

map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "   pick hidden term" })

map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "   nvchad themes" })

map("n", "gr", "<cmd> Telescope lsp_references <CR>", { desc = "lsp references" })
map("n", "gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "lsp definitions" })
map("n", "<C-j>", "<cmd> Telescope lsp_definitions <CR>", { desc = "lsp definitions" })
map("n", "gi", "<cmd> Telescope lsp_implementations <CR>", { desc = "lsp implementations" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions <CR>", { desc = "lsp type_definition" })
map("n", "<leader>s", "<cmd>Telescope session-lens search_session <CR>", { desc = "session" })
map("n", "gc", "<cmd>Telescope lsp_incoming_calls<CR>", { desc = "lsp incoming calls" })

-- lspconfig
-- map("n", "<C-j>", function()
--     vim.lsp.buf.definition()
-- end, { desc = "LSP definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover information" })

-- nvimtree
map("n", ";a", "<cmd> NvimTreeToggle <CR>", { desc = "toggle nvimtree" })
map("n", ";e", "<cmd> NvimTreeFocus <CR>", { desc = "focus nvimtree" })

-- goto-preview
map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
map("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", { noremap = true })
map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })
