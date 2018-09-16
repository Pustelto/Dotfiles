# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

## To-Do

- [ ] update brew and npm scripts to check if brew/npm exist and then run the scripts or quit with error
- [ ] install ZSH - via Brew, need to change shell using `chsh -s /usr/local/bin/zsh`
- [ ] write OS config script which will setup mac and install all necessary programs
  - install git, nodejs, npm, brew and global npm, zsh, hyper, tmux..., link zsh theme
  - configure some macOS settings (sound at startup, invisible folders, tab navigation in dialogs...)
- [ ] better formatted scripts output
- [ ] automate syncing/backup of changed files
  - some auto git commit and push?
  - watching dotfiles folder?
  - cron?
- [ ] script to do complete backup/restore
- [ ] move paths in scripts to export file/separate config instead of hardcoding it
