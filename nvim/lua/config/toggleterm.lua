require("toggleterm").setup{
    open_mapping = [[C-`]],
    shell = "/bin/fish",
    keys = {
        { "<C-j>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
}
