return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").gopls.setup{
        -- same configuration as above
      }
    end
  },
}
