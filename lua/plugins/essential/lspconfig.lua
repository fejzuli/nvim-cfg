return {
    "neovim/nvim-lspconfig",
    version = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
    },
    opts = {
        bashls = { settings = { bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        }}},
        clangd = {},
        cmake = {},
        lua_ls = { settings = { Lua = {
            completion = {
                callSnippet = "Replace",
            },
            workspace = {
                checkThirdParty = false,
            },
        }}},
        rust_analyzer = {},
        volar = {
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        },
    },
    config = function(_, opts)
        local capabilities = vim.tbl_deep_extend("force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )
        local lspcfg = require("lspconfig")
        for server, sopts in pairs(opts) do
            sopts.capabilities = capabilities
            lspcfg[server].setup(sopts)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local actions = require("core.actions").lsp
                local ropts = { buffer = ev.buf }
                actions.goto_declaration:react(vim.lsp.buf.declaration, ropts)
                actions.goto_definition:react(vim.lsp.buf.definition, ropts)
                actions.goto_type_definition:react(vim.lsp.buf.type_definition, ropts)
                actions.hover:react(vim.lsp.buf.hover, ropts)
                actions.list_implementations:react(vim.lsp.buf.implementation, ropts)
                actions.list_references:react(vim.lsp.buf.references, ropts)
                actions.signature_help:react(vim.lsp.buf.signature_help, ropts)
                actions.add_workspace_folder:react(vim.lsp.buf.add_workspace_folder, ropts)
                actions.remove_workspace_folder:react(vim.lsp.buf.remove_workspace_folder, ropts)
                actions.list_workspace_folders:react(function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, ropts)
                actions.rename:react(vim.lsp.buf.rename, ropts)
                actions.code_actions:react(vim.lsp.buf.code_action, ropts)
                actions.format:react(function()
                    vim.lsp.buf.format{ async = true }
                end, ropts)
            end,
        })
    end,
}
