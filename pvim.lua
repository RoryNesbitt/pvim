local dir = os.getenv("PVIM")
local on_windows = vim.loop.os_uname().version:match 'Windows'
local function join_paths(...) -- Function from nvim-lspconfig
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

-- Find the config
local init_path = join_paths(dir, "config", "init.")
local init_type = nil
if io.open(init_path .. "lua", "r") then
  init_type = "lua"
elseif io.open(init_path .. "vim", "r") then
  init_type = "vim"
end

vim.opt.rtp:append(join_paths(dir, "config"))
if init_type then
  vim.opt.rtp:append(join_paths(dir, "clutter", "packer"))
  vim.cmd.set('packpath=' .. join_paths(dir, "clutter", "packer"))
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
    vim.cmd.packadd("packer.nvim")
  end

  local _, packer = pcall(require, "packer")

  packer.init({
    package_root = join_paths(dir, "clutter", "packer", "pack"),
    compile_path = join_paths(dir, "clutter", "packer", "plugin", "packer_compiled.lua"),
  })

  -- Load the config
  vim.cmd.source(init_path .. init_type)
end -- of if init

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
