return {
    { -- theme
        "EdenEast/nightfox.nvim",
        version = "*",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("nightfox").setup(opts)
            vim.cmd("colorscheme carbonfox")
        end,
    },
    { -- bufferline
        "nvim-lualine/lualine.nvim",
        version = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        priority = 900,
        opts = {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { function() return vim.fn.getcwd() end },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {},
            winbar = {
                lualine_c = {
                    { "filename", path = 1 },
                },
            },
            inactive_winbar = {
                lualine_c = {
                    { "filename", path = 1 },
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        version = "3.*",
        event = "VeryLazy",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        version = "1.*",
        event = "VeryLazy",
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
}
