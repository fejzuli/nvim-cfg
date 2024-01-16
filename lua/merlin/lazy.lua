local M = {}

---Setup lazy.nvim plugin manager
function M.setup(opts)
    if vim.loop.fs_stat(vim.fn.stdpath("data") .. "/lazy") then
        vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
        require("lazy").setup({
            { "folke/lazy.nvim", version = "*" },
            { import = "plugins" },
        }, opts)
    else
        vim.api.nvim_create_user_command("LazyInstall", function()
            print("installing plugin manager lazy.nvim...")
            vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable",
                vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
            })
            print("\nFinished installing lazy.nvim.\nYou can use it by calling `:Lazy`.")
            vim.api.nvim_del_user_command("LazyInstall")
            require("merlin.util").suggest_restart()
        end, {})
    end
end

return M
