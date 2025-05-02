-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--Terminals
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=26 dir=. direction=horizontal<CR>', { desc = 'Horizontal Terminal' })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 dir=. direction=vertical<CR>', { desc = 'Vertical Terminal' })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm size=80 dir=. direction=float<CR>', { desc = 'Floating Terminal' })
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ direction='float', cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {desc = 'Lazygit Terminal', noremap = true, silent = true})

--New Splits
vim.keymap.set("n", "<leader>\\", "<cmd>:vsplit<CR>", { desc = 'Vertical Split' })
vim.keymap.set("n", "<leader>|", "<cmd>:split<CR>", { desc = 'Horizontal Split' })

-- Resize vertical split
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +5<CR>')
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -5<CR>')

-- Resize horizontal split
vim.keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>')

-- Buffers
vim.keymap.set('n', '<C-,>', '<cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<C-.>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<A-,>', '<cmd>BufferLineMovePrev<CR>')
vim.keymap.set('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>')
--vim.keymap.set('n', '<C-q>', '<cmd>bdelete<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>BufferLinePick<CR>')
-- vim: ts=2 sts=2 sw=2 et
