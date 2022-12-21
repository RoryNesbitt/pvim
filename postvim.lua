local dir = os.getenv("PVIM")
if dir then
  local on_windows = vim.loop.os_uname().version:match 'Windows'
  local function join_paths(...) -- Function from nvim-lspconfig
    local path_sep = on_windows and '\\' or '/'
    local result = table.concat({ ... }, path_sep)
    return result
  end

  vim.opt.undodir = join_paths(dir, "clutter", "undo")
  vim.opt.swapfile = false
  vim.opt.backup = false

  local mason_exists, mason = pcall(require, "mason")
  if mason_exists then
    mason.setup({
      install_root_dir = join_paths(dir,"clutter", "mason")
    })
  end
end
