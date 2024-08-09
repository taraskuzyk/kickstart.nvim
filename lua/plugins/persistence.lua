return {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {
        dir = '~/.local/state/nvim/sessions/', -- directory where session files are saved
        -- minimum number of file buffers that need to be open to save
        -- Set to 0 to always save
        need = 1,
        branch = true, -- use git branch to save session
    },
    config = function()
        local persistence = require 'persistence'
        vim.keymap.set('n', '<leader>qs', function()
            persistence.load()
        end)
        vim.keymap.set('n', '<leader>qS', function()
            persistence.select()
        end)
    end,
}
