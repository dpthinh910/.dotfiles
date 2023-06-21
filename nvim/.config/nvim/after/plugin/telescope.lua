local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_actions = require('telescope.actions')
local M = {}

telescope.setup = {
	defaults = {
    prompt_position = 'top',
    layout_strategy = 'horizontal',
    sorting_strategy = 'ascending',
    use_less = false
	}

}

M.find_files = function()
	telescope_builtin.find_files {
		find_command = {  'rq', '--files', '--iglob', '!.git', '--hidden' },
		previewer = false,
	}
end

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

return M
