# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around.

PS: sorry for czech, those are my internal notes what I want to add in the future

## Next steps

- udělat skript, který pustí npm install a parametry vezme z jiného souboru (seznam deps k nainstalování)
- udělat skript, který nainstaluje potřebné programy (viz níže)
- prolinkovat zsh theme do instalace
- udělat skript, který zjistí naisntalované brew a brew cask programy a uloží tento seznam do souboru
- udělat skript, který zjistí nainstalované globání npm balíčky a uloží je do souboru
  - `npm ls --depth=0 -g --parseable --long` vrací rozumný output, nejde ale zjisti nalinkované balíčky
  - linky mohu odstranít grepem pro -> u obyčejného ls a potom odstraněním dotyčného názvu pomocí sed
  - případně lze použít program [jq](https://stedolan.github.io/jq/), je to ale další dep.
- zkontrolovat path s androidem - je to zakomentované (a vždy bylo) - možná proto mi nefunguje RN z konzole?

## ToDo

-[x] hodit dotfiels na git
  - git (.gitconfig, .gitignote, .git-commit-template)
  - hyper: .hyper.js
  - zsh: .zshrc
  - tmux: .tmux.confm
  - vim: .vimrc,
-[ ] uložit a zazálohovat global npm scripty - vytánout výpis a uložit do souboru, který půjde ideálně přečíst do skriptu
-[ ] zazálohovat brew a brew cask (projít co tam je a zda to potřebuji)
-[ ] udělat config script pro OS (install brew a potřebné programy)
  - nainstaluje git, nodejs, npm, brew a brew cask věci, globaní npm, zsh, hyper, tmux..., nalinkuje zsh themu
  ? jaké je správné/potřebné pořadí pro instalaci jednotlivých programů
-[ ] udělat backup script - projde globalní npm a brew a uloží výstup do souboru pro pozdější znovu nainstalování
-[ ] udělat script pro nastavení OS
