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
  local real_require = require
  local plugins = {
    ["packer"] = function()
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
    end,
    ["lazy"] = function()
      local lazypath = join_paths(dir, "clutter", "lazy", "lazy", "lazy.nvim")
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable", -- latest stable release
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)
      local lazy_defaults = real_require"lazy.core.config".defaults
      local lazy_cache = real_require"lazy.core.cache"
      lazy_defaults.root = join_paths(dir, "clutter", "lazy", "lazy")
      lazy_defaults.lockfile = join_paths(dir, "clutter", "lazy", "lazy-lock.json")
      lazy_defaults.performance.rtp.reset = false
      lazy_defaults.performance.rtp.paths = {
        join_paths(dir, "clutter", "lazy", "lazy"),
      }
      lazy_defaults.readme.root = join_paths(dir, "clutter", "state", "lazy", "readme")
      lazy_cache.enabled = false
      lazy_cache.path = join_paths(dir, "clutter", "lazy", "cache")
    end,
    ["mason"] = function()
      real_require"mason".setup({
        install_root_dir = join_paths(dir,"clutter", "mason")
      })
    end,
  }

  --Anything that doesn't like being in a table
  local function extra_bits(plugin)
    if plugin == "packer" then
      real_require"packer".init({
        package_root = join_paths(dir, "clutter", "packer", "pack"),
        compile_path = join_paths(dir, "clutter", "packer", "plugin", "packer_compiled.lua"),
      })
    end
  end
  --overwrite require
  function require(plugin)
    if plugins[plugin] then
      --load custom plugin configs before loading plugin
      plugins[plugin]()
      plugins[plugin] = nil --only once
      extra_bits(plugin)
    end
    --run the normal require
    return real_require(plugin)
  end

  -- Load the config
  vim.cmd.source(init_path .. init_type)
end -- of if init

-- overwrite some settings
vim.opt.undodir = join_paths(dir, "clutter", "undo")
vim.opt.swapfile = false
vim.opt.backup = false

