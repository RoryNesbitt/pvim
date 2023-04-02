# Portable-vim

pvim, AKA seanvim, is an AllInOne-directory Neovim wrapper.

pvim will download the latest Neovim appimage and contain your config and
plugins to within the download directory. This should work on any linux computer
that can run an appimage, and can be downloaded from any computer that has git
and curl.

pvim no longer assumes your plugin manager and only runs setup when you try to
load one. If you would like to use pvim with a different plugin manager open an
issue and I'll have a look at support.  
Note: The plugin manager needs to have an option to change where it installs
plugins to.

## Supported plugin managers
- [Packer.nvim](https://github.com/wbthomason/packer.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)

## Installation

Clone pvim to whatever location you wish then add it to your path.

```sh
git clone https://github.com/RoryNesbitt/pvim
git clone <YOURCONFIG> pvim/config
PATH="$(pwd)/pvim:$PATH"
```

If you are using a bootstap function you will need to add `and not
os.getenv("PVIM")` to the if condition to avoid double downloading your plugin
manager.

## Finding Neovim

On running `pvim`, it will first look for the Neovim appimage in the pvim
directory, if it is not there it will check if `nvim` is in path, if neither are
available it will download the latest appimage.  
If you would rather use the appimage than the current installed version, you can
force it's use with `-f` or specify an appimage location with `-i <appimage>`.

## Updating

You can then use `pvim -u` to update pvim itself, your config (if it is a git
repo) and the appimage (if not using `-i`).

## Your Config

For the most part pvim can be used with any config and it will work out of the
box, however if you have anything specifically referencing
`vim.fn.stdpath("config")` then you can get the pvim config directory with
`os.getenv("pvim").."/config"`. The following function will work for both cases:

```lua
local function findConfig()
  local configDir = os.getenv("PVIM")
  if configDir then
    configDir = configDir.."/config"
  else
    configDir = vim.fn.stdpath("config")
  end
  return configDir
end
```

## Known issues

- plugins which specifically look for the xdg standard directories will not contain
their files to the pvim directory

## ToDo

- [x] Check the commands actually work
- [x] Thank the neovim matrix guys 
- [x] improve the README 
- [x] improve the update-command to update your config as well as the appimage 
- [x] Fix that one error from packer `Can't open file /path/to/manifest for writing` 
- [x] Add windows compatibility (in the lua, no pvim.bat yet) 
- [ ] Add pvim.bat 
- [x] Remove the PackerCompile workaround, or at least make it nicer 
- [x] support init.vim (Or no init) 
- [x] find other outside files that Neovim uses (e.g. undo directory) 
- [x] Add mason.nvim installation directory 
