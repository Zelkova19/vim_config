return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- или "main", если используете новую ветку
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"rust", "javascript", "zig", "python", "go", "lua",
				},
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
