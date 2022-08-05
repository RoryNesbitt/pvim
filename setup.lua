local portable = os.getenv("RNVIM")
if portable then
  vim.opt.rtp:append(portable .. "/config")
  vim.opt.rtp:append(portable .. "/pack/packer/start/*")

  local fn = vim.fn
  local install_path = portable .. "/pack/packer/start/packer.nvim"
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
    package_root = portable .. '/pack',
  })
end
