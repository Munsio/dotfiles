return {
	"numToStr/FTerm.nvim",
	config = function()
		local fterm = require("FTerm")

		vim.keymap.set("n", "<leader>tt", function() fterm:toggle() end, {desc = "[T]oggle [T]erminal"})
		vim.keymap.set("t", "<leader>tt", function() fterm:toggle() end, {desc = "[T]oggle [T]erminal"})

		local lazygit = fterm:new({
			ft = 'fterm_lazygit',
			cmd = "lazygit"
		})

		vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, {desc = 'Toggle [L]azy[G]it'})
		vim.keymap.set("t", "<leader>lg", function() lazygit:toggle() end, {desc = 'Toggle [L]azy[G]it'})
	end
}
