local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").gopls.setup{
	capabilities = capabilities,	
      }
    end
  },
}
