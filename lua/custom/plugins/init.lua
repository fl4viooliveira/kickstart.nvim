-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.g.polyglot_disabled = { 'sleuth' } -- Disable sleuth plugin from polyglot

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

  { 'sheerun/vim-polyglot' },

  { 'evanleck/vim-svelte' },

}
