local M = {}

---Suggest user to restart nvim
function M.suggest_restart()
    local res = vim.fn.confirm(
        [[A restart is required. Do you wish to do that now?
Note that you'll need to manually start nvim after it quits.]],
        "yes\nno"
    )

    if res == 1 then
        vim.cmd("confirm qall")
    end
end

return M
