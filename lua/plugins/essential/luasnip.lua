local actions = require("core.actions").snippet

return {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp LUAJIT_OSX_PATH=/opt/local",
    keys = {
        actions.expand_or_jump:lazy(function()
            local ls = require("luasnip")
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end),
        actions.jump_back:lazy(function()
            local ls = require("luasnip")
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end),
        actions.cycle_choice:lazy(function()
            local ls = require("luasnip")
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)
    },
    opts = {
        --keep last snippet around to jump back to it
        history = true,
        --update snippets while typing
        updateevents = "TextChanged,TextChangedI",
    },
}
