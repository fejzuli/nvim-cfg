local actions = require("core.actions").tree

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        actions.toggle:lazy("<Cmd>Neotree toggle last<CR>")
    },
    cmd = "Neotree",
    opts = {
        close_if_last_window = false,
        hide_root_node = true,
        source_selector = {
            winbar = true,
        },
    },
}
