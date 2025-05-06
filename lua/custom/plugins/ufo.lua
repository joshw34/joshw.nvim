return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  opts = {
    -- More specific provider_selector that explicitly disables UFO for special buffers
    provider_selector = function(bufnr, filetype, buftype)
      -- Return empty string to completely disable UFO for these buffer types
      if buftype == 'terminal' or buftype == 'nofile' or buftype == 'quickfix' or buftype == 'prompt' then
        return ''
      end
      
      -- For toggleterm specifically
      if filetype == 'toggleterm' then
        return ''
      end
      
      -- For regular files, use normal providers
      return {'lsp', 'treesitter'}
    end,
  },
  init = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function(_, opts)
    -- Setup UFO with provided options
    require('ufo').setup(opts)
    -- LSP folding capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    -- Apply to all LSP servers
    local lspconfig_util = require('lspconfig.util')
    local orig_setup = lspconfig_util.default_config.on_setup
    
    lspconfig_util.default_config.on_setup = function(config)
      config.capabilities = vim.tbl_deep_extend(
        'force',
        config.capabilities or {},
        capabilities
      )
      if orig_setup then
        orig_setup(config)
      end
    end
    -- Add keymaps
    vim.keymap.set('n', 'zR', function()
      -- Safe open all folds with error handling
      pcall(function() require('ufo').openAllFolds() end)
    end, { desc = "Open all folds" })
    vim.keymap.set('n', 'zM', function()
      -- Safe close all folds with error handling
      pcall(function() require('ufo').closeAllFolds() end)
    end, { desc = "Close all folds" })
    vim.keymap.set('n', 'zK', function()
      -- Safe peek fold with error handling
      pcall(function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end, { desc = "Preview fold" })
  end
}
