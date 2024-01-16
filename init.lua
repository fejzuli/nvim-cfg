vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.loaded_perl_provider = 0

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = -1
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.linebreak = true
vim.o.showbreak = "> "
vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.number = true
vim.o.scrolloff = 10
vim.o.termguicolors = true

vim.g.c_syntax_for_h = 1

vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "<NOP>") -- disable default behavior

vim.keymap.set("i", "<S-CR>", "<End><CR>", { desc = "New line from anywhere" })
vim.keymap.set("i", "<C-,>", "<Esc>m`A,<Esc>``a", { desc = "Append \",\" to end of line" })
vim.keymap.set("i", "<C-;>", "<Esc>m`A;<Esc>``a", { desc = "Append \";\" to end of line" })

-- faster slow-scrolling
vim.keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll 3 lines down" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll 3 lines up" })

-- window navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.api.nvim_create_user_command("FactoryReset", function()
    local res = vim.fn.confirm("This will delete everything in share/nvim and state/nvim.\nDo you wish to continue?", "&yes\n&no", 2)
    if res == 1 then
        vim.fn.system({
            "rm",
            "-rf",
            vim.fn.stdpath("data"),
            vim.fn.stdpath("state"),
        })
        require("merlin.util").suggest_restart()
    end
end, {})

require("merlin.lazy").setup({
    install = {
        colorscheme = { "carbonfox", "default" },
    },
})
