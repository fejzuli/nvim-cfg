return {
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                lazy = true,
            },
        },
        keys = {
            { "<Leader><Leader>", "<Cmd>Telescope buffers<CR>", desc = "Open buffer" },
            { "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<Leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<Leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Find help" },
            { "<Leader>fk", "<Cmd>Telescope keymaps<CR>", desc = "Find keymap" },
            { "<Leader>fc", "<Cmd>Telescope commands<CR>", desc = "Find command" },
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
        "echasnovski/mini.align",
        version = "*",
        keys = {
            { "<Leader>al", mode = { "n", "x" } },
            { "<Leader>aL", mode = { "n", "x" } },
        },
        opts = {
            mappings = {
                start = "<Leader>al",
                start_with_preview = "<Leader>aL",
            },
        },
    },
}
