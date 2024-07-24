return {
    -- {
    --     "fejzuli/arabasta.nvim",
    --     dev = true,
    --     priority = 1001,
    --     init = function()
    --         vim.keymap.set("n", "<LocalLeader>rl", function()
    --             vim.cmd("Lazy reload arabasta.nvim")
    --             vim.cmd("colorscheme arabasta_light")
    --         end)
    --         vim.keymap.set("n", "H", "<cmd>Inspect<cr>")
    --     end,
    -- },
    {
        "fejzuli/rmfireworks.nvim",
        enabled = false,
        dev = true,
        priority = 1001,
        init = function()
            vim.keymap.set("n", "<Leader>rl", function()
                vim.cmd("Lazy reload rmfireworks.nvim")
                _G.f = require("rmfireworks")
            end)
            vim.keymap.set("n", "<Leader>rs", function()
                vim.cmd("hi clear")
                vim.cmd("colorscheme catppuccin")
            end)
            vim.keymap.set("n", "H", "<cmd>Inspect<cr>")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        init = function()
            vim.cmd("colorscheme catppuccin")
        end,
    },
    {
        "p00f/alabaster.nvim",
    },
    {
        "nvim-lualine/lualine.nvim",
        version = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        priority = 900,
        opts = {
            options = {
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                component_separators = "|",
                section_separators = "",
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
    {
        "echasnovski/mini.hipatterns",
        version = "0.*",
        event = "VeryLazy",
        opts = function()
            return {
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            }
        end,
    },
}
