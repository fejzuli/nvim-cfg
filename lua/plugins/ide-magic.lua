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
            clangd = {},
            cmake = {},
            gdscript = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            racket_langserver = {
                filetypes = { "racket" },
            },
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
                    map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
                    map("n", "K", vim.lsp.buf.hover, "LSP hover")
                    map("n", "gI", vim.lsp.buf.implementation, "List implementations")
                    -- TOTO find a different keymap <C-k> is used for window navigation
                    -- map("n", "<C-k>", vim.lsp.buf.signature_help, "Display signature information")
                    map("n", "<LocalLeader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                    map("n", "<LocalLeader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                    map("n", "<LocalLeader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "List workspace folders")
                    map("n", "<LocalLeader>D", vim.lsp.buf.type_definition, "Jump to type definition")
                    map("n", "<LocalLeader>rn", vim.lsp.buf.rename, "LSP rename")
                    map({ "n", "v" }, "<LocalLeader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "gr", vim.lsp.buf.references, "List references")
                    map("n", "<LocalLeader>cl", vim.lsp.codelens.run, "Run CodeLens")
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
    {
        "mrcjkb/haskell-tools.nvim",
        version = "3.*",
        dependencies = { "telescope.nvim" },
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            local ht = require("haskell-tools")
            local buf = vim.api.nvim_get_current_buf()
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    silent = true,
                    buffer = buf,
                    desc = desc,
                })
            end

            map("n", "<LocalLeader>hs", ht.hoogle.hoogle_signature, "Hoogle search")
            map("n", "<LocalLeader>ea", ht.lsp.buf_eval_all, "Evaluate all code snippets")
            map("n", "<LocalLeader>rr", ht.repl.toggle, "Toggle GHCi REPL for current package")
            map("n", "<LocalLeader>rf", function()
                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end, "Toggle GHCi REPL for current buffer")
            map("n", "<LocalLeader>rq", ht.repl.quit, "Close GHCi REPL")
        end,
    },
}
