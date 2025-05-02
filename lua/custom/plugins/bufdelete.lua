return {
    "famiu/bufdelete.nvim",
    config = function()
      vim.api.nvim_set_keymap(
        'n',
        '<C-q>',
        '<cmd>Bdelete<CR>',
        { noremap = true, silent = true, desc = "Close current buffer without closing split" }
      )
    end
}
