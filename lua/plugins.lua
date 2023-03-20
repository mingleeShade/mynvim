
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

--require('nvim-osc52-cfg')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- ChatGPT
    use ({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt_cfg").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            --"nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })

    -- plenary.nvim 依赖插件
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            print("in treesitter")
            ts_update()
        end,
    }

    -- nvim-osc52
    -- use ({
    --     'ojroques/nvim-osc52',
    -- })
end)
