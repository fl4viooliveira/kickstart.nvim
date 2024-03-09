-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  -- nvim-autopairs configuration
  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    requires = { 'hrsh7th/nvim-cmp' },
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  -- vim-wakatime plugin
  {
    'wakatime/vim-wakatime'
  },

  -- todo-comments plugin
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  { 'fatih/vim-go' },

  { 'evanleck/vim-svelte' },

  { 'NvChad/nvim-colorizer.lua' },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  { 'junegunn/gv.vim' },
  { 'nanotee/sqls.nvim' },

  -- C++ ---------------------
  { 'Civitasv/cmake-tools.nvim' },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Define DAP key mappings directly here
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map('n', '<leader>de', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
      map('n', '<leader>dr', '<cmd>lua require"dap".continue()<CR>', opts)
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
  },

}
