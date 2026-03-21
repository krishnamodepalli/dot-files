-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader><space>', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<M-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<M-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Tabs & Buffers
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', opts)
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts)
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer
vim.keymap.set('n', '<M-j>', ':bnext<CR>', opts)
vim.keymap.set('n', '<M-l>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<M-->', ':buffer #<CR>', opts) -- Go to previous buffer
vim.keymap.set('n', '<M-BS>', ':%bd!<CR>', opts)     -- Close all buffers

-- Window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Sort and unique sort in visual mode
vim.keymap.set('v', '<leader>s', ':sort<CR>', opts)
vim.keymap.set('v', '<leader>us', ':sort u<CR>', opts)


-- Keymaps for case conversion
local case = require("utils.case_convert")

local function convert_word(func)
  local word = vim.fn.expand("<cword>")
  local new = func(word)
  vim.cmd("normal! ciw" .. new)
end

vim.keymap.set("n", "<M-c>s", function()
  convert_word(case.to_snake_case)
end, { desc = "Snake case" })

vim.keymap.set("n", "<M-c>k", function()
  convert_word(case.to_kebab_case)
end, { desc = "Kebab case" })

vim.keymap.set("n", "<M-c>c", function()
  convert_word(case.to_camel_case)
end, { desc = "Camel case" })

vim.keymap.set("n", "<M-c>p", function()
  convert_word(case.to_pascal_case)
end, { desc = "Pascal case" })
