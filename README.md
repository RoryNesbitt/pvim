# Portable-vim

pvim, AKA seanvim, is an AllInOne-directory Neovim wrapper.

pvim will download the latest Neovim appimage and contain your config and
plugins to within the download directory. This should work on any linux computer
that can run an appimage, and can be downloaded from any computer that has git
and curl.

pvim now overrides where neovim sees the standard paths. This should work for
any plugin manager, if yours doesn't work open an issue and I will see what I
can do. If you find this breaks a tool that you like to call from neovim, I'll
try to fix that too.

## Installation

Clone pvim to whatever location you wish then add it to your path.

```sh
git clone https://github.com/RoryNesbitt/pvim
git clone <YOURCONFIG> pvim/config
ln -s "$(pwd)/pvim/pvim" "~/.local/bin/pvim"
```

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

pvim should run any config without changes, you no longer need to include a
check in your bootstrapper.
If you ever want to check if you are running in pvim use `os.getenv("pvim")`.

## Why change stdpath?

With the release of 0.12 and vim.pack I wanted to support users that are now
using that, which meant I needed to start doing so myself. I quickly discovered
that although I can change packpath that will only change where neovim looks for
the plugins, not where it installs them.

Previously I have always avoided changing standard paths as I don't want to
break any external calls you make from neovim, I think overriding vim.fn.stdpath
is a fair compromise.

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
- [x] Support vim.pack (and potentially all plugin managers implicitly)
