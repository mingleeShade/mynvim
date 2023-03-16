require('osc52').setup {
  max_length = 0,      -- Maximum length of selection (0 for no limit)
  silent     = false,  -- Disable message on successful copy
  trim       = false,  -- Trim surrounding whitespaces before copy
}

function copy()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
        require('osc52').copy_register('+')
        print("copy...")
    else
        print("copy failed...operator: " .. vim.v.event.operator .. " regname:" .. vim.v.event.regname .. ".")
    end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

