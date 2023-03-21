
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
--
vim.api.nvim_create_autocmd('FileType', {
  callback = function(tbl)
    local set_offset = require('bufferline.api').set_offset

    local bufwinid
    local last_width
    local autocmd = vim.api.nvim_create_autocmd('WinScrolled', {
      callback = function()
        bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

        local width = vim.api.nvim_win_get_width(bufwinid)
        if width ~= last_width then
          set_offset(width, 'FileTree')
          last_width = width
        end
      end,
    })

    vim.api.nvim_create_autocmd('BufWipeout', {
      buffer = tbl.buf,
      callback = function()
        vim.api.nvim_del_autocmd(autocmd)
        set_offset(0)
      end,
      once = true,
    })
  end,
  pattern = 'nerdtree', -- or any other filetree's `ft`
})

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
