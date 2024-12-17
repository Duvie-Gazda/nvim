-- Function to add the current folder to the command line
function AddCurrentFolderToCmd()
	local current_dir = vim.fn.getcwd()
	local current_cmd = vim.fn.input("Command: ", "", "file")
	local new_cmd = current_cmd .. " " .. current_dir

	-- Set the new command in the bottom of the screen
	vim.fn.setcmdline(new_cmd)
	print("Current directory added to command: " .. new_cmd)
end

-- Map Alt-F-Alt-A to add the current folder to the command line
vim.api.nvim_set_keymap("n", "<A-s><A-a>", ":lua AddCurrentFolderToCmd()<CR>", { noremap = true, silent = true })

-- Function to select a folder using Telescope
function SelectFolderForCmd()
	require("telescope.builtin").find_files({
		cwd = vim.fn.expand("%:p:h"),
		prompt_title = "Select a Folder",
		attach_mappings = function(prompt_bufnr, map)
			local actions = require("telescope.actions")
			actions.select_default:replace(function()
				local selection = require("telescope.actions.state").get_selected_entry()

				if selection then
					local selected_folder = selection.path
					vim.fn.setcmdline(selected_folder)
					print("Selected folder: " .. selected_folder)
				end

				actions.close(prompt_bufnr)
			end)
			return true
		end,
	})
end

-- Map Alt-F-Alt-P to select a folder using Telescope
vim.api.nvim_set_keymap("n", "<A-s><A-p>", ":lua SelectFolderForCmd()<CR>", { noremap = true, silent = true })
