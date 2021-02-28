# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

## Notes

On mac you have to install gnu-sed and use it instead of default mac sed.

## Backup process

1. Run `backup` alias
2.

## Restore process

## To-Do
- update iterm with tmux session name and disable tmux status bar https://github.com/daneah/iterm-components
- glg/glgg not working for small list (less wont activate pagination)
- [ ] update brew and npm scripts to check if brew/npm exist and then run the scripts or quit with error
- [ ] install ZSH - via Brew, need to change shell using `chsh -s /usr/local/bin/zsh`
- [ ] write OS config script which will setup mac and install all necessary programs
  - [inpiro](https://github.com/kentcdodds/dotfiles)
  - install git, nodejs, npm, brew and global npm, zsh, hyper, tmux..., link zsh theme
  - configure some macOS settings (sound at startup, invisible folders, tab navigation in dialogs...)
- [ ] better formatted scripts output
- [ ] automate syncing/backup of changed files
  - some auto git commit and push?
  - watching dotfiles folder?
  - cron?
- [ ] script to do complete backup/restore
- [ ] move paths in scripts to export file/separate config instead of hardcoding it

### macOS
show hidden files: `defaults write com.apple.finder AppleShowAllFiles YES`
disable sound effect on bootup `sudo nvram SystemAudioVolume=" "`

`npm config set save-exact true`
