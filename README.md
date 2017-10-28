# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

PS: sorry for czech, those are my internal notes what I want to add in the future

## Next steps

- udělat skript, který zjistí naisntalované brew a brew cask programy a uloží tento seznam do souboru
- udělat skript, který pustí npm install a parametry vezme z jiného souboru (seznam deps k nainstalování)
- udělat skript, který pustí brew install a parametry vezme z jiného souboru (seznam deps k nainstalování)
- udělat skript, který nainstaluje potřebné programy (spojí instalaci brew a npm)
- prolinkovat zsh theme do instalace

## To-Do

- [x] hodit dotfiels na git
  - git (.gitconfig, .gitignote, .git-commit-template)
  - hyper: .hyper.js
  - zsh: .zshrc
  - tmux: .tmux.confm
  - vim: .vimrc,
- [x] uložit a zazálohovat global npm scripty - vytánout výpis a uložit do souboru, který půjde ideálně přečíst do skriptu
- [ ] zazálohovat brew a brew cask (projít co tam je a zda to potřebuji)
- [ ] udělat config script pro OS (install brew a potřebné programy)
  - nainstaluje git, nodejs, npm, brew a brew cask věci, globaní npm, zsh, hyper, tmux..., nalinkuje zsh themu
  ? jaké je správné/potřebné pořadí pro instalaci jednotlivých programů
- [ ] udělat backup script - projde globalní npm a brew a uloží výstup do souboru pro pozdější znovu nainstalování
- [ ] udělat script pro nastavení OS
