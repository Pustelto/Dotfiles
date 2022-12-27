# Dotfiles

List of my dotfiles and configurations for easy setup of my dev environment. Feel free to look around. Right now I can version my dotfiles and backup/install names and versions of my global npm scripts.

For the dotfiles managment I'm using [dotfiles](https://github.com/jbernard/dotfiles) utility.

## Notes

On mac you have to install gnu-sed and use it instead of default mac sed.

## Backup process

1. Run `backup.sh` script in `setup_scripts` folder - backup for global NPM and cargo packages, programs installed via Brew and VS Code extensions.
2. Backup iTerm settings (profile) - Settings > Profiles > Other action > Save profile as JSON
3. Commit to git and push.
4. Backup other config files (move to other disk, **DO NOT COMMIT THOSE**):
   - Backup ssh keys - `~/.ssh`
   - `.zsh_history`, `.fzf.zsh`, `.z`
5. Backup my files (move to other disk, **DO NOT COMMIT THOSE**)
   - wifi networks - `/Library/Preferences/com.apple.wifi.known-networks.plist`
     - may be synced automatically
   - Raycast settings
   - fonts (mainly pathched MonoLisa with Nerd fonts)
   - other files (documents, photos etc.)

## Restore process

1. Signin with Apple ID in Preferences
2. Signin with Apple ID in App Store
3. Download `Dotfiles` repo and move it to `$HOME` dir.
4. Run setup.sh script (may need to change file permissions in order to run it)
5. Go to Tmux and hit Prefix + i to load the plugins
6. Firefix settinsg are not synced completely - update search engines
   - set Duckduckgo to default, add alias for Google and Youtube.

## To-Do

- NEPUSHNUTÉ EXPERIMENTÁLNÍ-BRANCHE - pushnout a pak smazat
- přesunout taby ve firefoxu na druhý počítač
- link to github repo and push updated stuff

- npm backup trims down `@` from namespace which will cause errors during install.
- update iterm with tmux session name and disable tmux status bar https://github.com/daneah/iterm-components
- glg/glgg not working for small list (less wont activate pagination)
- [ ] better formatted scripts output
- [ ] automate syncing/backup of changed files
  - some auto git commit and push?
  - watching dotfiles folder?
  - cron?
- [ ] script to do complete backup/restore
- [ ] move paths in scripts to export file/separate config instead of hardcoding it
