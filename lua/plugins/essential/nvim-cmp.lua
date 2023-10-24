local actions = require("core.actions").completion

return {
    "hrsh7th/nvim-cmp",
    version = false, -- latest release is very outdated
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = {
        sources = {
            {
                { name = "nvim_lsp" },
                { name = "luasnip" },
            },
            -- fallback
            {
                { name = "buffer" },
                { name = "path" },
            },
        },
        mapping = {
            [actions.next.trigger] = function()
                local cmp = require("cmp")
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    cmp.complete()
                end
            end,
            [actions.prev.trigger] = function()
                local cmp = require("cmp")
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    cmp.complete()
                end
            end,
            [actions.abort.trigger] = function()
                require("cmp").abort()
            end,
            [actions.confirm.trigger] = function()
                require("cmp").confirm{ select = true }
            end,
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    },
    config = function(_, opts)
        local cmp = require("cmp")

        opts.sources = cmp.config.sources(unpack(opts.sources))
        cmp.setup(opts)
    end,
}
