This is a little collection of my .files

# Init
A simple script used for fast install dotfiles at new profile.

Just builds some symlinks to tmux, zsh, vim, latexindent and cheat configs.

# Tmux
Binds 
- `ctrl+b, r` to hot config reload 
- `ctrl+k` to clear scrollback buffer (if `clear` is not enough for you)
- `alt+{lrud}` to change panels by alt + left/right/up/down arrows

Also, enables mouse support

# zshrc
Indentded to use with [systemwide setup of oh-my-zsh](https://gist.github.com/Rubikoid/3681575a5e267c5c20f66dcc31dba84e).

Set [candy](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#candy) theme.

Enabled plugins:
- git
- systemd
- docker

Changes dircolors to dark solarized.

Also setup some aliases for pacaur, tmux, ninja and cheat

Also creates function to pass the SSH Agent from KeePass in windows to WSL, for wsl1 and wsl2.

# vimrc
Setup dark solarized theme, force terminal to xterm-256.

Also setup some fixes to work with yaml without pain

BTW, if you setup vim, you need to run `cp ~/dotfiles/vim ~/.vim` to properly setup vim color scheme. This is excluded from init.sh because this action can harm existing vim installation 

# cheat
Just a simple cheats for tmux and vim, with correction for my bindings

# VSCode
[vscode_ext.sh](./vscode_ext.sh) contains a script for install all extensions

## [vscode.json](./vscode.json)
tldr: 
- Disable telemetry.
- Set `Monokai Dimmed` theme.
- Fix eol to \n.
- Move sidepanel to the right
- Python:
  - Force flake8
  - Force Pylance 
  - Set line lenght to 150
  - Suppress some flake8 warnings
- C:
  - Force C11/C++11
  - Force clang formatter and setup style
- Setup crazy latex frankenstein to run latex inside wsl, but running studio on host.

# Other
Also contain some configs for i3/sway and polybar/waybar, but they are useless.
