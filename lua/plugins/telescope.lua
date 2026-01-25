return {

	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',

	dependencies = { 'nvim-lua/plenary.nvim' },

	keys = function()
		return {

			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

			{ "<leader>fw", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },

			{ "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Search for buffers" },

			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Find tags" },

		}
	end,

}
