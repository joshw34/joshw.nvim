return {
  'romgrk/barbar.nvim',
  event = "BufReadPre",
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = true,
  },
  version = '^1.0.0',
  keys = {
    -- Move to previous/next
    { '<C-,>', '<Cmd>BufferPrevious<CR>', desc = 'Previous buffer' },
    { '<C-.>', '<Cmd>BufferNext<CR>', desc = 'Next buffer' },
    -- Re-order to previous/next
    { '<A-,>', '<Cmd>BufferMovePrevious<CR>', desc = 'Move buffer to previous' },
    { '<A-.>', '<Cmd>BufferMoveNext<CR>', desc = 'Move buffer to next' },
    -- Goto buffer in position...
    { '<C-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Buffer 1' },
    { '<C-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Buffer 2' },
    { '<C-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Buffer 3' },
    { '<C-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Buffer 4' },
    { '<C-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Buffer 5' },
    { '<C-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Buffer 6' },
    { '<C-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Buffer 7' },
    { '<C-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Buffer 8' },
    { '<C-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Buffer 9' },
    { '<C-0>', '<Cmd>BufferLast<CR>', desc = 'Last buffer' },
    -- Pin/unpin buffer
    { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Pin buffer' },
    -- Close buffer
    { '<C-q>', '<Cmd>BufferClose<CR>', desc = 'Close buffer' },
    -- Magic buffer-picking mode
    { '<C-p>', '<Cmd>BufferPick<CR>', desc = 'Pick buffer' },
    { '<C-s-p>', '<Cmd>BufferPickDelete<CR>', desc = 'Pick buffer to delete' },
    -- Sort automatically by...
    { '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', desc = 'Order by buffer number' },
    { '<Space>bn', '<Cmd>BufferOrderByName<CR>', desc = 'Order by name' },
    { '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', desc = 'Order by directory' },
    { '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', desc = 'Order by language' },
    { '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', desc = 'Order by window number' },
  },
}
