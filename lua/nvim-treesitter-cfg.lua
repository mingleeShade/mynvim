function is_large_file()
    local max_lines = 10000                                  -- 定义行数的阈值
    local current_lines = vim.api.nvim_buf_line_count(0)     -- 获取当前文件行数
    local max_size = 1 * 1024 * 1024                         -- 定义大小的阈值, 这里是 1MB
    local current_size = vim.fn.getfsize(vim.fn.expand("%")) -- 获取当前文件大小
    -- 行数太多或者大小太大，则认为是大文件
    if current_lines > max_lines or current_size > max_size then
        return true
    else
        return false
    end
end

require("nvim-treesitter.configs").setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "css", "vim", "lua", "javascript", "typescript", "tsx", "cpp", "c", "python" },
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        disable = function()
            if is_large_file() then
                return true
            end
            return false
        end,
        additional_vim_regex_highlighting = false,
    },
    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
        },
    },
    -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
    indent = {
        enable = false,
    },
})
-- 开启 Folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.wo.foldlevel = 99
