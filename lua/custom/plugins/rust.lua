-- Rust: rust-analyzer via rustaceanvim + Cargo.toml UX via crates.nvim.
-- rustaceanvim owns rust_analyzer, so init.lua skips it in the mason handler.

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = { border = 'rounded' },
        },
        server = {
          on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Rust: ' .. desc })
            end
            nmap('<leader>rr', function() vim.cmd.RustLsp('runnables') end, '[R]ust [R]unnables')
            nmap('<leader>rd', function() vim.cmd.RustLsp('debuggables') end, '[R]ust [D]ebuggables')
            nmap('<leader>rt', function() vim.cmd.RustLsp('testables') end, '[R]ust [T]estables')
            nmap('<leader>re', function() vim.cmd.RustLsp('explainError') end, '[R]ust [E]xplain error')
            nmap('<leader>rc', function() vim.cmd.RustLsp('openCargo') end, '[R]ust open [C]argo.toml')
            nmap('<leader>rp', function() vim.cmd.RustLsp('parentModule') end, '[R]ust [P]arent module')
            nmap('K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, 'Hover actions')
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              check = { command = 'clippy', extraArgs = { '--no-deps' } },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = 'never' },
                lifetimeElisionHints = { enable = 'never', useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = 'never' },
                renderColons = true,
                typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
              },
            },
          },
        },
        dap = {
          -- populated by codelldb path resolved from mason (see kickstart/debug.lua)
        },
      }
    end,
  },

  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup({
        completion = {
          cmp = { enabled = true },
          crates = { enabled = true },
        },
        lsp = {
          enabled = true,
          actions = true,
          -- Completion comes from the nvim-cmp source below; enabling it here
          -- too gives every Cargo.toml candidate twice.
          completion = false,
          hover = true,
        },
      })
      -- Extend nvim-cmp with the crates source when editing Cargo.toml.
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = 'Cargo.toml',
        callback = function()
          local ok, cmp = pcall(require, 'cmp')
          if not ok then return end
          cmp.setup.buffer({ sources = { { name = 'crates' }, { name = 'nvim_lsp' }, { name = 'luasnip' } } })
        end,
      })

      local crates = require('crates')
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = 'Crates: ' .. desc })
      end
      map('<leader>ct', crates.toggle, '[T]oggle')
      map('<leader>cr', crates.reload, '[R]eload')
      map('<leader>cv', crates.show_versions_popup, 'Show [V]ersions')
      map('<leader>cf', crates.show_features_popup, 'Show [F]eatures')
      map('<leader>cu', crates.update_crate, '[U]pdate crate')
      map('<leader>cU', crates.upgrade_crate, '[U]pgrade crate')
    end,
  },
}
