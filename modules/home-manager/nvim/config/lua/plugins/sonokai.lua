return {
	"sainnhe/sonokai",
	priority = 999,
	config = function()
		vim.g.sonokai_style = "atlantis"

		vim.cmd.colorscheme "sonokai"
	end
}
