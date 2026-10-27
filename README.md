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

> ![Static Badge](https://img.shields.io/badge/Status-Stable-brightgreen)
>
> This project doesn't see many updates recently but I will still fix any issues
> and work on new features as they come up. Maybe one day I'll even get round to
> windows support.

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
tell pvim to download it with either `-s` for stable or `-n` for nightly.

Alternatively, you may manually specify the path to an appimage with `-i
<appimage>`.

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
