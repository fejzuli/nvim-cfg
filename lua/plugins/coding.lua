return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-textsubjects",
        },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        event = "VeryLazy",
        init = function(plugin)
            -- copied from lazyvim https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        opts = {
            ensure_installed = {
                -- these five parsers should always be installed
                "c", "lua", "vim", "vimdoc", "query",
                -- others
                "bash", "fish",
                "cmake", "make",
                "markdown", "json", "jsonc", "ron", "toml", "yaml",
                "regex", "gitignore",
                "gdscript",
                "scheme", "racket",
                "rust", "go", "java",
                "javascript", "typescript", "html", "css",
            },
            -- tree-sitter-cli recommended if set to true
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                    },
                },
            },
            textsubjects = {
                enable = true,
                prev_selection = "<BS>",
                keymaps = {
                    ["<CR>"] = "textsubjects-smart",
                    ["a<CR>"] = "textsubjects-container-outer",
                    ["i<CR>"] = "textsubjects-container-inner",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.ai",
        version = "*",
        dependencies = {
            "nvim-treesitter",
            "nvim-treesitter-textobjects",
        },
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
            { "g[", mode = { "x", "o" } },
            { "g]", mode = { "x", "o" } },
        },
        opts = function()
            local spec_treesitter = require("mini.ai").gen_spec.treesitter

            return {
                custom_textobjects = {
                    f = spec_treesitter({
                        a = "@call.outer",
                        i = "@call.inner",
                    }),
                    F = spec_treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    -- whole buffer
                    G = function()
                        return {
                            from = { line = 1, col = 1, },
                            to = {
                                line = vim.fn.line("$"),
                                col = math.max(vim.fn.getline("$"):len(), 1),
                            },
                        }
                    end,
                },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        version = "5.*",
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "Format code",
            }
        },
        opts = {},
    },
    {
        "benknoble/vim-racket",
        version = false,
        lazy = false,
        priority = 500,
    },
    {
        "numToStr/Comment.nvim",
        version = "0.*",
        dependencies = { "nvim-ts-context-commentstring" },
        keys = {
            { "gcc", desc = "Toggle comment on line" },
            { "gbc", desc = "Toggle block-comment on line" },
            { "gcO", desc = "Add comment on line above" },
            { "gco", desc = "Add comment on line below" },
            { "gcA", desc = "Add comment at end of line" },
            { "gc", mode = { "n", "x" }, desc = "Toggle comment for motion or selection" },
        },
        opts = {},
        config = function(_, opts)
            opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            require("Comment").setup(opts)
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        version = false,
        dependencies = { "nvim-treesitter" },
        lazy = true,
        init = function() vim.g.skip_ts_context_commentstring_module = true end,
        opts = { enable_autocmd = false },
    },
}
