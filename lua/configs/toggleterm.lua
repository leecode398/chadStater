require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  -- size = function(term)
  --   if term.direction == "horizontal" then
  --     return 10
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  size = function()
    return vim.o.lines * 0.5
  end,

  --  open_mapping = [[<c-x>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = { "none", "fzf" },
  shade_terminals = false,
  shading_factor = "0", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  direction = "float", --'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "single", --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local function float_mappings(mapping)
  vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
    silent = true,
    noremap = true,
  })
  vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
    silent = true,
    noremap = true,
  })
end

local function horizontal_mappings(mapping)
  vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', {
    silent = true,
    noremap = true,
  })
  vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', {
    silent = true,
    noremap = true,
  })
end

-- horizontal_mappings "<C-x>"
-- float_mappings "<A-i>"
horizontal_mappings "<A-i>"
float_mappings "<C-x>"

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "jk", "<esc>", opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
