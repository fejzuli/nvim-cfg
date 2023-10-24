vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "<NOP>") -- disable default behavior

vim.keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll 3 lines down" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll 3 lines up" })

vim.keymap.set("n", "<Leader>ot", "<Cmd>terminal<CR>", { desc = "Open terminal" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set({ "n", "i" }, "<C-s>", "<Cmd>write<CR><Esc>", { desc = "Save current file" })

vim.keymap.set("n", "<LocalLeader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<LocalLeader>q", vim.diagnostic.setloclist, { desc = "Add diagnostic to loclist" })

require("core").setup({
    actions = {
        completion = {
            next = "<C-n>",
            prev = "<C-p>",
            abort = "<C-e>",
            confirm = "<C-y>",
        },
        general = {
            open_buffer = "<Leader>,",
            open_file = "<Leader>ff",
            search_in_cwd = "<Leader>ss",
            find_help = "<Leader>hh",
            find_help_keys = "<Leader>hk",
        },
        lsp = {
            goto_definition = "gd",
            goto_declaration = "gD",
            hover = "K",
            format = "<LocalLeader>f",
            rename = "<LocalLeader>rn",
            code_actions = "<LocalLeader>ca",
        },
        snippet = {
            expand_or_jump = "<C-k>",
            jump_back = "<C-j>",
            cycle_choice = "<C-l>",
        },
        tree = {
            toggle = "<Tab>",
        },
    },
    lazy = {
        devdir = "~/neovim/plugins"
    },
})
--
-- Indentation
vim.o.autoindent = true -- Copies indenting from previous line
vim.o.cindent = true -- C style indenting
vim.o.expandtab = true -- Expand <Tab> to spaces in indent mode
vim.o.smarttab = true -- <Tab> in front of line inserts "shiftwidth" spaces
                        -- <BS> will delete "shiftwidth" spaces
vim.o.shiftround = true -- Round to "shiftwidth" for "<<" and ">>"
vim.o.shiftwidth = 4 -- Spaces for each step of (auto)indent
vim.o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.o.softtabstop = 4 -- Number of spaces that a <Tab> counts for
                        -- while performing editing operations

-- Visual line breaking (only eye candy, does not change actual content)
vim.o.wrap = true -- Visually wrap lines too long for the screen
vim.o.breakindent = true -- Wrapped lines will keep visually same indentation
                           -- as beginning of line
vim.o.linebreak = true -- Visually wrap at breakpoint instead of last character on line
vim.o.showbreak = " >> " -- String to put at start of wrapped lines

-- Search
vim.o.ignorecase = true -- Search case insensitive
vim.o.smartcase = true -- Search case sensitive when query contains capital letters
vim.o.hlsearch = true -- Higlight search results
vim.o.incsearch = true -- Search as you type

-- Miscellaneous
vim.o.clipboard = "unnamed,unnamedplus" -- Use system clipboard
vim.o.cursorline = true -- Highlight line where cursor sits
vim.o.number = true -- Show line numbers
vim.o.scrolloff = 10 -- Minimal number lines to keep above and below the cursor
vim.o.termguicolors = true -- Enables 24-bit colors

vim.g.c_syntax_for_h = 1 -- set filetype to c instead of cpp for *.h files

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
