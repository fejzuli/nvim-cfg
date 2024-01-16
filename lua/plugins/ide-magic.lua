return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
        },
        event = "VeryLazy",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                mapping = cmp.mapping.preset.insert(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, { -- fallback
                    { name = "buffer" },
                    { name = "path" },
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "abbr", "kind", "menu" },
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        show_labelDetails = true,
                        menu = ({
                            buffer = "[buf]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[snip]",
                            path = "[path]",
                            cmdline = "[cmd]",
                        }),
                    }),
                },
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
                view = {
                    entries = {
                        name = "wildmenu",
                        separator = " | ",
                    },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp LUAJIT_OSX_PATH=/opt/local",
        lazy = true,
        opts = {
            keep_roots = true,
            link_roots = true,
            link_children = true,
            update_events = { "TextChanged", "TextChangedI" },
        },
        config = function(_, opts)
            local ls = require("luasnip")
            ls.setup(opts)

            vim.keymap.set({ "i", "s" }, "<C-k>", ls.expand_or_jump, {
                silent = true,
                desc = "Expand or jump in snippet",
            })
            vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, {
                silent = true,
                desc = "Jump back in snippet",
            })
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {
                silent = true,
                desc = "Cycle through snippet choice nodes",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        version = false,
        dependencies = {
            "cmp-nvim-lsp",
            "folke/neodev.nvim",
        },
        lazy = false,
        opts = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            racket_langserver = {},
            rust_analyzer = {},
        },
        config = function(_, opts)
            require("neodev").setup()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspcfg = require("lspconfig")
            for server, sopts in pairs(opts) do
                sopts.capabilities = capabilities
                lspcfg[server].setup(sopts)
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, {
                            buffer = ev.buf,
                            desc = desc,
                        })
                    end
                    map("n", "gd", vim.lsp.buf.definition, "Goto definition")
                    map("n", "K", vim.lsp.buf.hover, "LSP hover")
                    map({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, "Code action")
                end,
            })
        end,
    },
    {
        "Olical/conjure",
        version = "4.*",
        ft = { "racket" },
        init = function()
            vim.g["conjure#client#racket#stdio#command"] = "racket -I sicp"
        end,
        config = function()
            require("conjure.main").main()
            require("conjure.mapping")["on-filetype"]()
            vim.api.nvim_create_autocmd("BufNewFile", {
                group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
                pattern = { "conjure-log-*" },
                callback = function() vim.diagnostic.disable(0) end,
                desc = "Conjure Log disable LSP diagnostics",
            })
        end,
    },
}
