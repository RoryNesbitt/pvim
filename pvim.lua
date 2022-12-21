local dir = os.getenv("PVIM")
if dir then
  local on_windows = vim.loop.os_uname().version:match 'Windows'
  local function join_paths(...) -- Function from nvim-lspconfig
    local path_sep = on_windows and '\\' or '/'
    local result = table.concat({ ... }, path_sep)
    return result
  end

  vim.opt.rtp:append(join_paths(dir, "config"))
  vim.opt.rtp:append(join_paths(dir, "clutter", "packer"))
  vim.cmd('set packpath=' .. join_paths(dir, "clutter", "packer"))
  vim.g.loaded_remote_plugins = 1

  local fn = vim.fn
  local install_path = join_paths(dir, "clutter", "packer", "pack", "packer", "start", "packer.nvim")
  if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    print("Installing packer")
    vim.cmd([[packadd packer.nvim]])
  end

  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
  end

  packer.init({
    package_root = join_paths(dir, "clutter", "packer", "pack"),
    compile_path = join_paths(dir, "clutter", "packer", "plugin", "packer_compiled.lua"),
  })

  -- Load the config
  local init_path = join_paths(dir, "config", "init.")
  if io.open(init_path .. "lua", "r") then
    dofile(join_paths(dir, "config", "init.lua"))
  elseif io.open(init_path .. "vim", "r") then
    vim.cmd.source(join_paths(dir, "config", "init.vim"))
  end

  -- overwrite some settings
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
