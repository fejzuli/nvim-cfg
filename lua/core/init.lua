local M = {}

---@class core.Opts
---@field actions core.actions.Opts?
---@field lazy core.lazy.Opts?

---@param opts core.Opts
function M.setup(opts)
    opts = opts or {}

    require("core.actions").setup(opts.actions or {})
    require("core.lazy").setup(opts.lazy or {})

    vim.api.nvim_create_user_command("FactoryReset",
        function()
            local res = vim.fn.confirm("This will delete everything in share/nvim and state/nvim.\nDo you wish to continue?", "&yes\n&no", 2)

            if res == 1 then
                vim.fn.system({
                    "rm",
                    "-rf",
                    vim.fn.stdpath("data"),
                    vim.fn.stdpath("state"),
                })
                require("util").prompt_restart()
            end
        end,
    {})
end

return M
