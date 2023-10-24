local actions = require("core.actions")

return {
    {
        "nvim-telescope/telescope.nvim",
        version = "^0.1",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = true,
        keys = {
            actions.general.open_buffer:lazy("<Cmd>Telescope buffers<CR>"),
            actions.general.open_file:lazy("<Cmd>Telescope find_files<CR>"),
            actions.general.search_in_cwd:lazy("<Cmd>Telescope live_grep<CR>"),
            actions.general.find_help:lazy("<Cmd>Telescope help_tags<CR>"),
            actions.general.find_help_keys:lazy("<Cmd>Telescope keymaps<CR>"),
        },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "^build/",
                },
            },
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    ignore_current_buffer = true,
                },
                keymaps = {
                    show_plug = false,
                },
            },
        },
        config = function(_, opts)
            local ts = require("telescope")

            ts.setup(opts)
            ts.load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
    },
}
