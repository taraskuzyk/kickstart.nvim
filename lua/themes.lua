return {
    'navarasu/onedark.nvim',
    opts = {
        style = 'darker',
    },
    priority = 1000,
    init = function()
        vim.cmd 'colorscheme onedark'
    end,
}
