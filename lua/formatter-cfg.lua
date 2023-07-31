-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            -- require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == "special.lua" then
                    return nil
                end

                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--indent-type Spaces",
                        "--indent-width 4",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        html = {
            require("formatter.filetypes.html").prettier,
        },
        css = {
            require("formatter.filetypes.css").prettier,
        },
        javascript = {
            require("formatter.filetypes.javascript").prettier,
        },
        python = {
            require("formatter.filetypes.python").black,
        },
        cpp = {
            -- require("formatter.filetypes.cpp").clangformat,
            function()
                if vim.fn.filereadable(".astylerc") == 1 then
                    -- print("there is astylerc")
                    return {
                        exe = "astyle",
                        args = {
                            "--options=.astylerc",
                        },
                        stdin = true,
                    }
                elseif vim.fn.filereadable(".clang-format") == 1 then
                    -- print("use clang-format")
                    return {
                        exe = "clang-format",
                        args = {
                            "-style=file",
                            "-assume-filename",
                            util.escape_path(util.get_current_buffer_file_name()),
                        },
                        stdin = true,
                    }
                else
                    -- print("else")
                    return {
                        exe = "astyle",
                        args = {
                            "--options=$HOME/.config/nvim/.astylerc",
                        },
                        stdin = true,
                    }
                end
            end,
        },
        markdown = {
            require("formatter.filetypes.markdown").prettier,
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})
