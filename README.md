# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

## Notes

On mac you have to install gnu-sed and use it instead of default mac sed.

## Backup process

1. Run `backup` alias
2. Backup other mac files
   - wifi networks - `/Library/Preferences/com.apple.wifi.known-networks.plist`
   - iterm profile - Settings > Profiles > Other action > Save profile as JSON
   - ssh keys - `~/.ssh`
   - `.zsh_history`, `.fzf.zsh`, `.z`
3. Backup my files
   - Raycast scripts
   - repos and dev-todos (eg. `pax -rw -pe ~/work/**/dev-todo.md ~/dev-todo`) to copy all `dev-todo.md` for `~/work` to `~/dev-todo` while keeping the folder structure (path) intact.
   - other files (documents, photos etc.)

## Restore process

1. Signin with Apple ID in Preferences
2. Signin with Apple ID in App Store
3. Clone or download `Dotfiles` repo to `$HOME` dir
4. Run setup.sh script (may need to change file permissions in order to run it)

## To-Do
- update iterm with tmux session name and disable tmux status bar https://github.com/daneah/iterm-components
- glg/glgg not working for small list (less wont activate pagination)
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
