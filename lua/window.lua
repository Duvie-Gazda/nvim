local is_maximized = false
local win_layout = nil

function ToggleMaximize()
	if is_maximized then
		-- Restore the saved layout
		vim.fn.winrestview(win_layout)
		vim.cmd("wincmd =") -- Reset all windows to equal size
		is_maximized = false
	else
		-- Save the current layout and maximize the window
		win_layout = vim.fn.winsaveview()
		vim.cmd("tabnew") -- Create a new tab with the current window
		vim.cmd("wincmd T") -- Move the current window to the new tab
		is_maximized = true
	end
end

vim.api.nvim_set_keymap("n", "<Leader>m", ":lua ToggleMaximize()<CR>", { noremap = true, silent = true })

require("oil").setup({
	options = {
		columns = { "icon", "size" },
	},
	keymaps = {
		["<A-l>"] = "actions.select", -- Alt+l to select a file
		["<A-a>"] = "actions.preview",
		["<A-h>"] = "actions.parent",
		["<C-s>"] = function() -- Ct l+s to save without confirming
			require("oil").save({ confirm = false }) -- Save action without confirmation
		end,
	},
})

-- Function to open terminal in current folder of current buffer
local function open_terminal_in_current_folder()
	local current_path = vim.api.nvim_buf_get_name(0)
	local folder_path = vim.fn.fnamemodify(current_path, ":p:h") -- Get the folder path

	-- Open a horizontal split with the terminal
	vim.cmd("split term://" .. folder_path)
end

-- Keymap for Alt-t + Alt-f to open terminal in the current folder of the current buffer
local opts = { noremap = true, silent = true }

-- Use <A-t><A-f> to toggle terminal in the current folder of the buffer
vim.api.nvim_set_keymap("n", "<A-t><A-f>", ":ToggleTerm dir=%:p:h<CR>", opts)

-- Helper to set keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Map Alt-<number> (1-9) to jump to corresponding window
-- for i = 1, 9 do
-- 	keymap("n", string.format("<M-%d>", i), string.format("<Cmd>%d wincmd w<CR>", i), opts)
-- end
