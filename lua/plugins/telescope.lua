local ts_select_dir_for_grep = function(prompt_bufnr)
    local action_state = require 'telescope.actions.state'
    local fb = require('telescope').extensions.file_browser
    local live_grep = require('telescope.builtin').live_grep
    local current_line = action_state.get_current_line()

    fb.file_browser {
        files = false,
        depth = false,
        attach_mappings = function(prompt_bufnr)
            require('telescope.actions').select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                live_grep {
                    results_title = relative .. '/',
                    cwd = absolute,
                    default_text = current_line,
                }
            end)

            return true
        end,
    }
end

local select_one_or_multi = function(prompt_bufnr)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        require('telescope.actions').close(prompt_bufnr)
        for _, j in pairs(multi) do
            if j.path ~= nil then
                vim.cmd(string.format('%s %s', 'edit', j.path))
            end
        end
    else
        require('telescope.actions').select_default(prompt_bufnr)
    end
end

return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
        require('telescope').setup {
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
                ['file_browser'] = {
                    theme = 'ivy',
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ['i'] = {
                            -- your custom insert mode mappings
                        },
                        ['n'] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
            pickers = {
                live_grep = {
                    mappings = {
                        i = {
                            ['<C-f>'] = ts_select_dir_for_grep,
                            ['<CR>'] = select_one_or_multi,
                        },
                        n = {
                            ['<C-f>'] = ts_select_dir_for_grep,
                        },
                    },
                },
            },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Tele[S]cope [F]iles' })
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Tele[S]cope [G]rep' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Tele[S]cope [Q]uickfix' })

        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = 'Tele[S]scope [/] Open Files' })

        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = 'Tele[S]cope [N]eovim files' })
    end,
}
