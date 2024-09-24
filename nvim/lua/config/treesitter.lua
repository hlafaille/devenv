require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "java" }, -- languages to be installed
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
