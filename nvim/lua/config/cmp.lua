-- Require the necessary modules
local cmp = require'cmp'
local luasnip = require'luasnip'

vim.o.completeopt = 'menu,menuone,noselect'

-- Setup nvim-cmp
cmp.setup({
  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
  },
  snippet = {
    -- REQUIRED - you'll need a snippet engine here or it'll error
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Customize your key mappings
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For snippet support
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text', -- Show symbols and text
      maxwidth = 50,        -- Prevent the popup from showing more than 50 chars
    }),
  },
})
