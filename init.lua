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
vim.o.inccommand = "split"

vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.termguicolors = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.showmode = false

vim.o.undofile = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.g.c_syntax_for_h = 1

vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "<NOP>") -- disable default behavior

vim.keymap.set("i", "<S-CR>", "<End><CR>", { desc = "New line from anywhere" })
vim.keymap.set("i", "<C-CR>", "<Esc>m`o<Esc>``a", { desc = "Place new line below without moving cursor" })
vim.keymap.set("i", "<S-Space>", "  <Left>", { desc = "Pre-pad, use inside of curly brackets" })
vim.keymap.set("i", "<C-,>", "<Esc>m`A,<Esc>``a", { desc = "Append \",\" to end of line" })
vim.keymap.set("i", "<C-;>", "<Esc>m`A;<Esc>``a", { desc = "Append \";\" to end of line" })

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Turn off search highlights" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- faster slow-scrolling
vim.keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll 3 lines down" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll 3 lines up" })

-- window stuff
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-CR>", "<C-w>x", { desc = "Swap windows" })
vim.keymap.set("n", "<Left>", "5<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<Right>", "5<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<Up>", "5<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<Down>", "5<C-w>-", { desc = "Decrease window height" })

-- diagnostics
vim.keymap.set("n", "<Leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics quickfix list" })
vim.keymap.set("n", "<Leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic message in float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic message" })

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
    dev = {
        path = "~/projects/nvim-plugins",
    },
    install = {
        colorscheme = { "carbonfox", "default" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
