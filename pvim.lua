local dir = os.getenv("PVIM")
local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

-- Redirect all relevant stdpaths into the pvim directory
vim.fn.stdpath = function(loc)
  return join_paths(dir, "clutter", loc)
end

-- Find the config
local init_path = join_paths(dir, "config", "init.")
local init_type = nil
if io.open(init_path .. "lua", "r") then
  init_type = "lua"
elseif io.open(init_path .. "vim", "r") then
  init_type = "vim"
end

vim.opt.rtp:prepend(join_paths(dir, "config"))
vim.opt.rtp:append(join_paths(dir, "config", "after"))
if init_type then
  -- Add pvim data site to packpath (for vim.pack and packadd)
  vim.opt.packpath:prepend(join_paths(dir, "clutter", "data", "site"))

  local real_require = require
  local plugins = {
    ["lazy"] = function()
      local lazy_defaults = real_require "lazy.core.config".defaults
      local lazy_cache = real_require "lazy.core.cache"
      lazy_defaults.performance.rtp.reset = false
      lazy_cache.enabled = false
    end,
  }

  function require(plugin)
    if plugins[plugin] then
      plugins[plugin]()
      plugins[plugin] = nil
    end
    return real_require(plugin)
  end

  -- Load the config
  vim.cmd.source(init_path .. init_type)
end

-- overwrite some settings
vim.opt.undodir = join_paths(dir, "clutter", "undo")
vim.opt.swapfile = false
vim.opt.backup = false
