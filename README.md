# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

- když dám alt-f tak mi to vyhodí hromadu kopií dnaého psaného textu - místo doplnění jednoho slova
- mazaání git branches
branch cleaner:
git branch -d `git branch | grep -E 'fix*'`
-  udělat interaktivní skript, kterým si vyberu branche na smazání

## To-Do

- [x] upload dotfiles to git
  - git (.gitconfig, .gitignote, .git-commit-template)
  - zsh: .zshrc
  - tmux: .tmux.confm
  - vim: .vimrc,
- [x] save global npm packages to file
- [x] install global npm packages defined in backup file
- [x] backup brew and brew cask programs
- [x] write script to install brew nad brew cask programes defined in backup file
- [x] move alias definitions to separate file for better portability across different shell paltforms
- [ ] backup VS code extensions and settings `code --list-extensions`
  - how to restore the backup
  - save code settings and keybindings as well
- [ ] backup AppStore apps - via MAS command
  - how to restore backup
- [ ] update brew and npm scripts to check if brew/npm exist and then run the scripts or quit with error
- [ ] install ZSH - via Brew, need to change shell using `chsh -s /usr/local/bin/zsh`
- [ ] install/backup zsh plugins (autocomplete, syntax highlight) - via antibody
- [ ] link ZSH theme from Dotfiles folder to zsh install folder - has to be separate repo
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
- [ ] update ZSH theme
  - existuje něco jako iterm theme s definici bareva text stylů [see](https://github.com/sindresorhus/iterm2-snazzy)
  - polish git status in prompt - merging, rebasing, correct spaces between branch name and statuses
  - possible make a new repo for theme and publish it separately for easier installation in the future
