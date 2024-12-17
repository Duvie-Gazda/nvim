function SetKeyMap(command, vimCommand, configs)
	vim.keymap.set("n", command, vimCommand .. "<CR>", configs)
	vim.keymap.set("i", command, "<Esc>" .. vimCommand .. "<CR>", configs)
end

function SetKeyMapFunc(command, func, configs)
	vim.keymap.set("n", command, func, configs)
	vim.keymap.set("i", command, func, configs)
end
