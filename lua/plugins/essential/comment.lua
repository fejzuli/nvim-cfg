return {
    "numToStr/Comment.nvim",
    version = "^0.8",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    lazy = false,
    opts = {},
    config = function(_, opts)
        opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

        require("Comment").setup(opts)
    end,
}
