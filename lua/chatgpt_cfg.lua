local M = {}

local options = {
    keymaps = {
        close = { "<C-c>" },
        submit = "<C-s>",
        yank_last = "<C-y>",
        yank_last_code = "<C-k>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
        select_session = "<Space>",
        rename_session = "r",
        delete_session = "d",
    },
}

function M.setup()
    require("chatgpt").setup(options)
end

return M
