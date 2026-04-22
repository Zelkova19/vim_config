local M = {}

local sep = package.config:sub(1, 1)

local function join(...)
  return table.concat({ ... }, sep)
end

local function exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function parent_dir(path)
  return vim.fs.dirname(path)
end

function M.project_root(bufnr)
  bufnr = bufnr or 0
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local start = filename ~= "" and filename or vim.fn.getcwd()
  local dir = vim.fn.fnamemodify(start, ":p:h")

  local markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  }

  while dir and dir ~= "" do
    for _, marker in ipairs(markers) do
      if exists(join(dir, marker)) then
        return dir
      end
    end

    local parent = parent_dir(dir)
    if not parent or parent == dir then
      break
    end
    dir = parent
  end

  return vim.fn.getcwd()
end

function M.find_python(bufnr)
  local root = M.project_root(bufnr)
  local candidates = {
    ".venv/bin/python",
    "venv/bin/python",
    ".env/bin/python",
    "env/bin/python",
  }

  for _, rel in ipairs(candidates) do
    local path = join(root, rel)
    if exists(path) then
      return path
    end
  end

  local virtual_env = os.getenv("VIRTUAL_ENV")
  if virtual_env then
    local path = join(virtual_env, "bin", "python")
    if exists(path) then
      return path
    end
  end

  if vim.fn.executable("python3") == 1 then
    return vim.fn.exepath("python3")
  end

  return "python"
end

return M