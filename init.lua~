require("core.configs")
require("core.mappings")
require("core.lazy")

-- ~/.config/nvim/init.lua
local venv = require("core.venv")

-- Инициализация при запуске Neovim
venv.setup_neovim_python()

function OpenURLUnderCursor()
	local url = vim.fn.expand("<cfile>")
	if url ~= "" then
		os.execute("xdg-open " .. url)
	end
end

vim.api.nvim_set_keymap("n", "<leader>go", ":lua OpenURLUnderCursor()<CR>", { noremap = true, silent = true })
-- Включить автоматическое определение (опционально)
--venv.auto_detect_on_dir_change()

-- Команда для ручного обновления venv
--vim.api.nvim_create_user_command("VenvSelect", function()
--	venv.setup_neovim_python()
--end, { desc = "Обновить виртуальное окружение" })
