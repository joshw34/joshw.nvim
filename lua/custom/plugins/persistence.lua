return {
  "folke/persistence.nvim",
  event = "VeryLazy",
  config = function()
    require("persistence").setup({
      -- Set options but don't auto-save
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- Directory to store sessions
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    })
    
    -- Set up keymaps for manual session control
    vim.keymap.set("n", "<leader>ss", function()
      -- Save the session
      require("persistence").save()
      vim.notify("Session saved", vim.log.levels.INFO)
    end, { desc = "Save session" })
    
    vim.keymap.set("n", "<leader>sl", function()
      -- List and restore sessions
      require("persistence").load()
    end, { desc = "Load session" })
    
    vim.keymap.set("n", "<leader>sd", function()
      -- Manually delete the current session
      local path = require("persistence").session_path(nil)
      vim.fn.delete(path)
      vim.notify("Session deleted: " .. path, vim.log.levels.INFO)
    end, { desc = "Delete session" })
  end,
}
