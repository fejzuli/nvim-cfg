local M = {}

---@class core.lazy.Opts
---@field devdir string?

---Setup lazy.nvim plugin manager
---@param opts core.lazy.Opts
function M.setup(opts)
    -- if lazy is installed
    if vim.loop.fs_stat(vim.fn.stdpath("data") .. "/lazy") then
        -- activate lazy.nvim
        vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
        require("lazy").setup({
            { "folke/lazy.nvim", version = "*" },
            { import = "plugins.essential" },
            { import = "plugins.ui" },
            { import = "plugins.util" },
            { import = "plugins" },
        }, {
            dev = {
                path = opts.devdir,
                fallback = false,
            },
            install = {
                    colorscheme = { "default" },
            },
        })
    else
        -- create user command to install lazy.nvim
        vim.api.nvim_create_user_command("LazyInstall",
            function()
                print("installing plugin manager lazy.nvim...")
                vim.fn.system({
                    "git",
                    "clone",
                    "--filter=blob:none",
                    "https://github.com/folke/lazy.nvim.git",
                    "--branch=stable",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
                })
                print()
                print("Finished installing lazy.nvim.")
                print("You can use it by calling `:Lazy`.")

                vim.api.nvim_del_user_command("LazyInstall")
                require("core.util").suggest_restart()
            end,
        {})
    end
end

return M
