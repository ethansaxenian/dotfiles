local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({ bufner = bufnr })
   lsp.buffer_autoformat()
   local opts = { buffer = bufnr }

   vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
   vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end, opts)
   vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
   vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
   vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
   vim.keymap.set({ 'n', 'x' }, '<leader>gf', function() vim.lsp.buf.format({ async = true }) end, opts)
end)

lsp.ensure_installed({
   'pyright',
   'ruff_lsp',
   'jsonls',
   'lua_ls',
   'bashls',
})


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').pyright.setup({
   before_init = function(_, config)
      local function get_python_path(workspace)
         local util = require('lspconfig/util')
         local path = util.path
         -- Use activated virtualenv.
         if vim.env.VIRTUAL_ENV then
            return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
         end

         -- Find and use virtualenv in workspace directory.
         for _, pattern in ipairs({ '*', '.*' }) do
            local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
            if match ~= '' then
               return path.join(path.dirname(match), 'bin', 'python')
            end
         end

         -- Fallback to system Python.
         return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
      end
      local python_path = get_python_path(config.root_dir)
      config.settings.python.pythonPath = python_path
   end
})

require('lspconfig').ruff_lsp.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').jsonls.setup({})


lsp.setup()


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
   mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp_action.tab_complete(),
      ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

      ['<C-Space>'] = cmp.mapping.complete(),
   }
})
