# Portable-vim

pvim, AKA seanvim, is an AllInOne-directory Neovim wrapper.

pvim will download the latest Neovim appimage and contain your config and
plugins to within the download directory. This should work on any linux computer
that can run an appimage, and can be downloaded from any computer that has git
and curl.

This is setup and intended for use with packer based configs, I don't know how
well it would do with other plugin managers.

## installation

To install it alongside my config use:

```sh
git clone --recursive https://github.com/RoryNesbitt/pvim
```

To use your own config run:

```sh
git clone https://github.com/RoryNesbitt/pvim
git clone <YOURCONFIG> pvim/config
```

## First run/getting Neovim

On running `pvim`, it will first look for the Neovim appimage in the pvim
directory, if it is not there it will check if `nvim` is in path, if neither are
available it will download the latest appimage.  
If you would rather use the appimage than the current installed version, or you
want to update the appimage, run `pvim-update`.

## Known issues

- yo we're doing good here

## ToDo

- [x] Check the commands actually work
- [x] Thank the neovim matrix guys
- [x] improve the README
- [x] improve the update-command to update your config as well as the appimage
- [x] Fix that one error from packer `Can't open file /path/to/manifest for writing`
- [x] Add windows compatibility (in the lua, no pvim.bat yet)
- [x] Remove the PackerCompile workaround, or at least make it nicer
- [x] support init.vim (Or no init)
- [ ] find other outside files that Neovim uses (e.g. undo directory)
