return {
    "EdenEast/nightfox.nvim",
    version = "*",
    lazy = false,
    priority = 1000,
    opts = {
        options = {
            transparent = true,
        },
    },
    config = function(_, opts)
        require("nightfox").setup(opts)
        vim.cmd("colorscheme carbonfox")
    end,
}
