local dir = os.getenv("PVIM")
if dir then
  vim.opt.rtp:append(dir .. "/config")
  vim.cmd('set packpath=' .. dir)

  local fn = vim.fn
  local install_path = dir .. "/pack/packer/start/packer.nvim"
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
    display = {
      open_fn = function()
        return require("packer.util").float({})
      end,
    },
    package_root = dir .. '/pack',
    compile_path = dir .. '/plugin/packer_compiled.lua',
  })
end
