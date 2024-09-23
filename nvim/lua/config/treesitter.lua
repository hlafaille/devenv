require('lazy').setup({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate', -- Automatically install missing parsers when entering buffer
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = "all", -- Install all supported languages or specify a list like {"lua", "python"}
      highlight = {
        enable = true,              -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      }
    })
  end
})
