local fzf = require("fzf-lua")

vim.api.nvim_set_keymap("n", "<A-a><A-e>", ":lua vim.diagnostic.open_float()<CR>", {})
require("hover").setup({
	init = function()
		require("hover.providers.lsp")
	end,
	preview_opts = {
		border = "rounded",
	},
	title = true,
})

-- Map the hover functionality to a key
-- vim.keymap.set({ "i", "n" }, "<A-S-a><A-S-e>", ":Telescope diagnostic", {})
vim.keymap.set("n", "<A-a><A-a>", require("hover").hover, { desc = "Hover (LSP)" })
vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "Hover Select" })
vim.keymap.set({ "i", "n" }, "<A-w>", ":bd<CR>", { desc = "Close" })
vim.keymap.set({ "i", "n" }, "<A-s><A-g>", ":FzfLua live_grep<CR>", {})
vim.keymap.set({ "i", "n" }, "<A-s><A-z>", "<C-o>", {})
vim.keymap.set({ "i", "n" }, "<A-s><A-a>", "<C-i>", {})
vim.keymap.set("n", "<A-e><A-f>", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.api.nvim_set_keymap(
	"n",
	"<A-h>",
	":lua require('oil').cd(require('oil.util').get_parent_path())<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set({ "i", "n" }, "<A-e><A-r>", ":Remote", {})
vim.keymap.set({ "i", "n" }, "<C-z>", "u", {})
vim.api.nvim_set_keymap("n", "<A-t>", ":lcd %:p:h | terminal<CR>", { noremap = true, silent = true })

require("autoclose").setup()

-- require("nvim-web-devicons").setup({})

-- Setup bufferline with icons

for i = 1, 9 do
	vim.api.nvim_set_keymap(
		"n",
		"<A-" .. i .. ">",
		"<Cmd>BufferLineGoToBuffer " .. i .. "<CR>",
		{ noremap = true, silent = true }
	)
end

-- Keymap to grep a word in the current buffer's directory
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
	"n",
	"<A-s><A-g>",
	":lua require('telescope.builtin').live_grep({ cwd = vim.fn.expand('%:p:h') })<CR>",
	opts
)
