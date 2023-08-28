# Homebrew Bundle
# https://github.com/Homebrew/homebrew-bundle

tap "homebrew/aliases"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"
tap "homebrew/services"

brew "asdf"
# brew "agedu"
brew "bats-core"
brew "clojure"
brew "curl"
brew "direnv"
brew "dog"
brew "duf"
# brew "exercism"
brew "ffmpeg"
brew "git"
# brew "go"
# brew "golang-migrate"
brew "htop"
brew "httpie"
brew "jq"
# brew "leiningen" # Clojure dependency
brew "lsd"
brew "mas"
brew "miller"
brew "neovim"
brew "node"
brew "postgresql@14", restart_service: true
brew "rsync"
brew "shellcheck"
brew "shfmt"
brew "sqlite"
brew "ssh-copy-id"
# brew "terraform"
brew "tmux"
brew "tree"
brew "unzip"
brew "wget"
brew "whalebrew"
brew "yarn"
brew "youtube-dl"
brew "zsh"

# cask "1password"
cask "alacritty"
cask "authy"
cask "bitwarden"
cask "brave-browser"
cask "dbeaver-community"
cask "deezer"
cask "discord"
cask "docker"
cask "dropbox"
cask "firefox"
cask "font-hack-nerd-font"
cask "google-chrome"
cask "google-cloud-sdk"
cask "google-drive"
cask "gpg-suite"
# cask "grammarly"
# cask "inkscape"
cask "keepassx"
cask "keybase"
cask "libreoffice"
cask "macvim"
# cask "microsoft-teams"
# cask "miro"
cask "openemu"
# cask "openzfs"
# cask "protonvpn"
cask "rectangle"
cask "signal"
cask "simplenote"
cask "skype"
cask "slack"
# cask "steam"
cask "transmission"
cask "telegram-desktop"
cask "thunderbird"
cask "transmission"
# cask "virtualbox"
cask "visual-studio-code"
cask "vlc"
cask "whatsapp"
cask "zoom"

mas "Flow", id: 1423210932
mas "Microsoft To Do", id: 1274495053
mas "Tailscale", id: 1475387142
mas "Toggl Track", id: 1291898086
mas "TweetDeck", id: 485812721
# mas "GarageBand", id: 682658836
# mas "iMovie", id: 408981434
# mas "Keynote", id: 409183694
# mas "LastPass", id: 926036361
# mas "Numbers", id: 409203825
# mas "Pages", id: 409201541

