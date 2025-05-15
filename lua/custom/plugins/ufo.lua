return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  ft = { "c", "cpp" },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      -- Skip folding for special buffer types (like neotree)
      local special_buftypes = {
        'terminal',
        'nofile',
        'help',
        'quickfix',
        'prompt',
      }
      
      -- Check if it's a special buffer type
      if vim.tbl_contains(special_buftypes, buftype) then
        return false -- Disable folding for these buffer types
      end
      
      -- Skip folding for specific filetypes that commonly cause issues
      local skip_filetypes = {
        'neo-tree',
        'NvimTree',
        'Trouble',
        'alpha',
        'dashboard',
        'packer',
        'mason',
        'lazy',
        'fugitive',
        'oil',
      }
      
      if vim.tbl_contains(skip_filetypes, filetype) then
        return false
      end
      
      -- For C/C++ files, use LSP first, then treesitter as fallback
      if filetype == 'c' or filetype == 'cpp' then
        return {'lsp', 'treesitter'}
      end
      
      -- For other supported filetypes, use treesitter with indent fallback
      return {'treesitter', 'indent'}
    end,
    
    -- Close fold kinds define when a range with this kind will be folded
    close_fold_kinds_for_ft = {
      default = {'imports', 'comment'},
    },
    
    -- Add fold text configuration for better display
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ('  %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      
      table.insert(newVirtText, {suffix, 'MoreMsg'})
      return newVirtText
    end
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
    
    -- Add keymaps with better error handling
    vim.keymap.set('n', 'zR', function()
      local success, err = pcall(function() 
        require('ufo').openAllFolds() 
      end)
      if not success then
        vim.notify('UFO: Failed to open all folds: ' .. err, vim.log.levels.WARN)
      end
    end, { desc = "Open all folds" })
    
    vim.keymap.set('n', 'zM', function()
      local success, err = pcall(function() 
        require('ufo').closeAllFolds() 
      end)
      if not success then
        vim.notify('UFO: Failed to close all folds: ' .. err, vim.log.levels.WARN)
      end
    end, { desc = "Close all folds" })
    
    vim.keymap.set('n', 'zK', function()
      local success, err = pcall(function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
      if not success then
        vim.notify('UFO: Failed to preview fold: ' .. err, vim.log.levels.WARN)
        vim.lsp.buf.hover()
      end
    end, { desc = "Preview fold" })
  end
}
