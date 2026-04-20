-- ~/.config/nvim/lua/config/venv.lua
local M = {}

-- Основная функция поиска виртуального окружения
function M.find_venv()
	-- Возможные имена папок с виртуальными окружениями
	local venv_names = { "venv", ".venv", "env", ".env" }
	local current_dir = vim.fn.getcwd()

	for _, name in ipairs(venv_names) do
		-- Ищем папку, начиная с текущей директории и поднимаясь выше
		local venv_path = vim.fn.finddir(name, current_dir .. ";")
		if venv_path ~= "" then
			local python_path = venv_path .. "/bin/python"

			-- Проверяем, существует ли python в этой папке
			if vim.fn.filereadable(python_path) == 1 then
				return python_path
			end
		end
	end

	-- Если venv не найден, проверяем переменную окружения
	local env_python = os.getenv("VIRTUAL_ENV")
	if env_python then
		return env_python .. "/bin/python"
	end

	return nil
end

-- Установка найденного venv для Neovim
function M.setup_neovim_python()
	local python_path = M.find_venv()

	if python_path then
		vim.g.python3_host_prog = python_path
		print("[VENV] Установлен Python: " .. python_path)

		-- Обновляем PATH для Neovim
		local venv_dir = vim.fn.fnamemodify(python_path, ":h:h")
		vim.env.PATH = venv_dir .. "/bin:" .. vim.env.PATH

		return true
	else
		print("[VENV] Виртуальное окружение не найдено")
		return false
	end
end

-- Автоматическое определение при смене директории
function M.auto_detect_on_dir_change()
	-- Создаем автокоманду для смены директории
	vim.api.nvim_create_autocmd("DirChanged", {
		pattern = "*",
		callback = function()
			vim.defer_fn(function()
				M.setup_neovim_python()
			end, 100)
		end,
		desc = "Автоматическое определение venv при смене директории",
	})
end

return M
