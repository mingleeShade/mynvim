-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
--
-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(tbl)
--     local set_offset = require('bufferline.api').set_offset

--     local bufwinid
--     local last_width
--     local autocmd = vim.api.nvim_create_autocmd('WinScrolled', {
--       callback = function()
--         bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

--         local width = vim.api.nvim_win_get_width(bufwinid)
--         if width ~= last_width then
--           set_offset(width, 'FileTree')
--           last_width = width
--         end
--       end,
--     })

--     vim.api.nvim_create_autocmd('BufWipeout', {
--       buffer = tbl.buf,
--       callback = function()
--         vim.api.nvim_del_autocmd(autocmd)
--         set_offset(0)
--       end,
--       once = true,
--     })
--   end,
--   pattern = 'nerdtree', -- or any other filetree's `ft`
-- })

--require('nvim-osc52-cfg')

vim.keymap.set("n", "<leader>p", '<cmd>lua require("spectre").open()<CR>', {
    desc = "Open Spectre",
})
vim.keymap.set("n", "<leader>pw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word",
})
vim.keymap.set("v", "<leader>pw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word",
})
vim.keymap.set("n", "<leader>pp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file",
})

function Test()
    ignore_list_map = vim.g.ignore_file_list_map
    print("sss")
    for key, value in pairs(ignore_list_map) do
        print('key:' .. key)
    end
end

vim.keymap.set("n", "<leader>dd", '<cmd>lua Test()<CR>', {
    desc = "Test func"
})

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- ChatGPT
    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt_cfg").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    })

    -- formatter.nvim
    use({
        "mhartington/formatter.nvim",
        -- config = function()
        --     require("formatter-cfg")
        -- end
    })

    -- -- telescope 插件
    -- use({
    --     "nvim-telescope/telescope.nvim",
    --     requires = { { "nvim-lua/plenary.nvim" }, { "kdheepak/lazygit.nvim" } },
    --     config = function()
    --         require("telescope").load_extension("lazygit")
    --     end,
    -- })

    -- which-key
    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for keymaps that start with a native binding
                    i = { "j", "k", "\\" },
                    v = { "j", "k" },
                },
                disable = {
                    buftypes = {
                        "quickfix",
                        "nowrite",
                        "help",
                        "terminal",
                        "prompt",
                    },
                },
            })
        end,
    })

    use({
        "romgrk/barbar.nvim",
        config = function()
            require("barbar-cfg")
        end,
    })

    -- plenary.nvim 依赖插件
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            print("in treesitter")
            ts_update()
        end,
    })

    use({
        "nvim-pack/nvim-spectre",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("spectre").setup({})
        end,
    })

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        coifig = function()
            require("diffview").setup({
                merge_tool = {
                    layout = "diff4_mixed",
                },
            })
        end,
    })

    use("Bekaboo/dropbar.nvim")
    use("nvim-tree/nvim-web-devicons")

    -- nvim-osc52
    -- use ({
    --     'ojroques/nvim-osc52',
    -- })
end)
