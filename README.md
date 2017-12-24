# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

## To-Do

- [x] upload dotfiles to git
  - git (.gitconfig, .gitignote, .git-commit-template)
  - hyper: .hyper.js
  - zsh: .zshrc
  - tmux: .tmux.confm
  - vim: .vimrc,
- [x] save global npm packages to file
- [x] install global npm packages defined in backup file
- [x] backup brew and brew cask programs
- [x] write script to install brew nad brew cask programes defined in backup file
- [x] move alias definitions to separate file for better portability across different shell paltforms
- [ ] update brew and npm scripts to check if brew/npm exist and then run the scripts or quit with error
- [ ] instal ZSH
- [ ] link ZSH theme from Dotfiles folder to zsh install folder
- [ ] write OS config script which will setup mac and install all necessary programs
  - install git, nodejs, npm, brew and global npm, zsh, hyper, tmux..., link zsh theme
  - configure some macOS settings (sound at startup, invisible folders, tab navigation in dialogs...)
- [ ] better formatted scripts output
- [ ] move paths in scripts to export file/separate config instead of hardcoding it
- [ ] update ZSH theme (inpiro: [spaceship](https://github.com/denysdovhan/spaceship-zsh-theme))
  - improve git repo status handlers and symbols
  - rename device, evaluate all prompt parts if they are necessary
  - possible make a new repo for theme and publish it separately for easier installation in the future
