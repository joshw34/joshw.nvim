return {
  "Mofiqul/vscode.nvim",
  lazy = false,  -- Make sure it loads during startup
  priority = 1000,  -- Set high priority to load it before other plugins
  config = function()
    -- Configure the theme
    require('vscode').setup({
      -- For dark theme (default)
      -- style = 'dark',
      
      -- For light theme
      -- style = 'light',
      
      -- Enable transparent background
      transparent = false;
      
      -- Enable italic comments
      italic_comments = true,
      
      -- Underline `@markup.link.*` variants
      underline_links = true,
      
      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,
      
      -- Apply theme colors to terminal
      terminal_colors = true,
      
      -- You can override specific colors if needed
      -- color_overrides = {
      --   vscLineNumber = '#FFFFFF',
      -- },
      group_overrides = {
        ['@keyword.directive'] = { fg='#C586C0', bg='NONE' },
      }
    })
    
    -- Set the colorscheme
    vim.cmd.colorscheme "vscode"
    
    -- Set background (dark or light)
    vim.o.background = 'dark'
  end,
}
