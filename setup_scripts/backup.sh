echo "Startup a backup of installed packages"

$HOME/Dotfiles/setup_scripts/npm_backup.sh
$HOME/Dotfiles/setup_scripts/brew_backup.sh
$HOME/Dotfiles/setup_scripts/cargo_backup.sh
$HOME/Dotfiles/setup_scripts/code_backup.sh

echo "Backup of installed packages SUCCESSFUL"
