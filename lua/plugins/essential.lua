return {
    { -- automatically adjust shiftwidth and expandtab based on current file
        "tpope/vim-sleuth",
        version = false,
        event = "VeryLazy",
    },
    { -- improved behavior when buffer is removed
        "echasnovski/mini.bufremove",
        version = false,
        event = "BufDelete",
        opts = {},
    },
    { -- auto-pairing of " ( etc.
        "echasnovski/mini.pairs",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        "ecasnovski/mini.surround",
        version = "*",
        keys = {
            { "gz", mode = { "n", "x", "o" } },
        },
        opts = {
            mappings = {
                add = "gza",
                delete = "gzd",
                find = "gzf",
                find_left = "gzF",
                highlight = "gzh",
                replace = "gzr",
                update_n_lines = "gzn",
                suffix_last = "l",
                suffix_next = "n",
            },
        },
    },
    {
        "echasnovski/mini.ai",
        version = "*",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
            { "g[", mode = { "x", "o" } },
            { "g]", mode = { "x", "o" } },
        },
        opts = {},
    },
    { -- quickly jump around in a buffer
        "ggandor/leap.nvim",
        version = false,
        dependencies = { "tpope/vim-repeat" },
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap to other buffer" },
        },
        opts = {},
        config = function(_, opts)
            local leap = require("leap")
            leap.opts = vim.tbl_deep_extend("force", leap.opts, opts)
            leap.add_default_mappings()
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
    { -- leap style f/F/t/T motions
        "ggandor/flit.nvim",
        version = false,
        dependencies = { "leap.nvim" },
        keys = {
            { "f", mode = { "n", "x", "o" } },
            { "F", mode = { "n", "x", "o" } },
            { "t", mode = { "n", "x", "o" } },
            { "T", mode = { "n", "x", "o" } },
        },
        opts = {},
    },
    {
        "stevearc/oil.nvim",
        version = "2.*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        keys = {
            { "-", "<Cmd>Oil<CR>", desc = "Open parent directory in oil" },
        },
        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
                "permissions",
            },
            keymaps = {
                ["<C-h>"] = false,
                ["gS"] = "actions.select_split",
                ["<C-l>"] = false,
                ["gl"] = "actions.refresh",
            },
        },
    },
    {
        "mbbill/undotree",
        version = "*",
        keys = {
            { "<Leader>ut", vim.cmd.UndotreeShow, desc = "Open undo tree" },
        },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    },
}
