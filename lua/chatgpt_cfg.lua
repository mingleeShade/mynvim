local M = {}

-- 设置快捷键
local map = vim.api.nvim_set_keymap
map("n", "<leader>cg", "<Cmd>ChatGPT<CR>", { noremap = true, silent = true })

local options = {
    popup_input = {
        submit = "<C-s>",
    },
    openai_params = {
        max_tokens = 600,
    },
}

--vim.api.nvim_set_keymap('n', '<leader>dc', ':ChatGPTEditWithInstructions<CR>', { noremap = true, silent = true })

function M.setup()
    require("chatgpt").setup(options)
end

return M
