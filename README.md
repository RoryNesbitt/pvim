# Portable-vim

pvim, AKA seanvim, is an AllInOne-directory Neovim wrapper.

pvim will download the latest Neovim appimage and contain your config and
plugins to within the download directory. This should work on any linux computer
that can run an appimage, and can be downloaded from any computer that has git
and curl.

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

## ToDo

- [x] Check the commands actually work
- [x] Thank the neovim matrix guys
- [x] improve the README
- [x] improve the update-command to update your config as well as the appimage
- [ ] Fix that one error from packer `Can't open file /path/to/manifest for writing`
- [ ] Add windows compatibility
