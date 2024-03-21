# my personal neovim config

To install the plugin manager execute `:LazyInstall`.
You will be prompted to restart neovim. Confirm with `y` and run nvim again.
After plugins are installed you should restart neovim again.

You can view installed plugins with `:Lazy`, plugin configurations are located in lua/plugins.

You can uninstall all plugins with `:FactoryReset`.


# useful keybindings
Leader is bound to `,` and LocalLeader to `<Space>`.

 - `<Leader>fk` find keybindings
 - `<Leader>fh` find help
 - `<Leader>ff` find files
 - `<Leader>fg` search for pattern in cwd
 - `<Leader><Leader>` switch buffer
 - `-` open file explorer (press again to go up a directory and `<C-c>` to close it)
 - `<C-;>` add ";" to end of line
 - `<C-,>` add "," to end of line
 - `<S-CR>` start new-line from end of line

## when a language server is attached

 - `K` inspect word under cursor
 - `gd` go to definition
 - `<LocalLeader>ca` code actions
 - `<LocalLeader>rn` rename


# useful links

 - [find keys to map](https://docs.google.com/spreadsheets/d/1EJMLr_MPrYiO1TKJ2MjNkR-fA5Wgxa782-f0Wtdpz0w/edit?pli=1#gid=1302333873)
