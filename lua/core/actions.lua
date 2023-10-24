local Action = {
    mode = "n",
}

function Action:new(opts)
    self.__index = self
    return setmetatable(opts, self)
end

function Action:react(reaction, opts)
    if self.trigger then
        vim.keymap.set(self.mode, self.trigger, reaction, vim.tbl_extend("force", {
            desc = self.desc,
            silent = self.silent,
        }, opts or {}))
    end
end

function Action:lazy(reaction)
    if self.trigger then
        return { self.trigger, reaction, mode = self.mode, desc = self.desc }
    end
end

local M = {
    completion = {
        next = Action:new{ desc = "Select next completion item" },
        prev = Action:new{ desc = "Select previous completion item" },
        abort = Action:new{ desc = "Abort completion" },
        confirm = Action:new{ desc = "Confirm completion" },
    },
    general = {
        open_buffer = Action:new{ desc = "Open buffer" },
        open_file = Action:new{ desc = "Open file" },
        search_in_cwd = Action:new{ desc = "Search in CWD" },
        find_help = Action:new{ desc = "Find help" },
        find_help_keys = Action:new{ desc = "Find help about keymaps" },
    },
    lsp = {
        goto_declaration = Action:new{ desc = "Goto declaration" },
        goto_definition = Action:new{ desc = "Goto definition" },
        goto_type_definition = Action:new{ desc = "Goto type definition" },
        hover = Action:new{ desc = "Hover" },
        list_implementations = Action:new{ desc = "List implementations" },
        list_references = Action:new{ desc = "List references" },
        signature_help = Action:new{ desc = "Signature info" },
        add_workspace_folder = Action:new{ desc = "Add workspace folder" },
        remove_workspace_folder = Action:new{ desc = "Remove workspace folder" },
        list_workspace_folders = Action:new{ desc = "List workspace folders" },
        rename = Action:new{ desc = "Rename" },
        code_actions = Action:new{ desc = "Code actions" },
        format = Action:new{ desc = "Format code" },
    },
    snippet = {
        expand_or_jump = Action:new{ desc = "Expand or jump forward in snippet", mode = { "i", "s" }, silent = true },
        jump_back = Action:new{ desc = "Jump backwards in snippet", mode = { "i", "s" }, silent = true },
        cycle_choice = Action:new{ desc = "Cycle through snippet choice nodes", mode = "i" },
    },
    tree = {
        toggle = Action:new{ desc = "Toggle tree" },
    },
}

---@class core.actions.Opts
---@field completion core.actions.Opts.Completion?
---@field general core.actions.Opts.General?
---@field lsp core.actions.Opts.Lsp?
---@field snippet core.actions.Opts.Snippet?
---@field tree core.actions.Opts.Tree?

---@class core.actions.Opts.Completion
---@field next string?
---@field prev string?
---@field abort string?
---@field confirm string?

---@class core.actions.Opts.General
---@field open_buffer string?
---@field open_file string?
---@field search_in_cwd string?
---@field find_help string?
---@field find_help_keys string?

---@class core.actions.Opts.Lsp
---@field goto_declaration string?
---@field goto_definition string?
---@field goto_type_definition string?
---@field hover string?
---@field list_implementations string?
---@field list_references string?
---@field signature_help string?
---@field add_workspace_folder string?
---@field remove_workspace_folder string?
---@field list_workspace_folders string?
---@field rename string?
---@field code_actions string?
---@field format string?

---@class core.actions.Opts.Snippet
---@field expand_or_jump string?
---@field jump_back string?
---@field cycle_choice string?

---@class core.actions.Opts.Tree
---@field toggle string?

---@param opts core.actions.Opts
function M.setup(opts)
    for category, actions in pairs(opts) do
        for action, trigger in pairs(actions) do
            M[category][action].trigger = trigger
        end
    end
end

return M
