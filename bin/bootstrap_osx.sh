#!/bin/bash

# NOTE: For mas to work with free App Store apps, you MUST do this:
# Go to System Preferences/App Store, select 'Save Password' for Free Downloads.

# NOTE: The current version of 'mas' in homebrew does not prompt for passwords.
read -p "Mac App Store username: " masuser
read -s -p "Mac App Store password: " maspass
echo ""

# TODO: Add a cron to update brew every 24 hours (maybe around lunchtime)
# TODO: Casks for the following apps:
# Box Sync
# Docker for mac
#
RED='\033[0;31m'
NC='\033[0m' # No Color

# Show hidden files
echo -e "${RED}Forcing OSX to always show hidden files${NC}"
defaults write -g AppleShowAllFiles -bool true

# Pull dotfiles
echo -e "${RED}Cloning dotfiles${NC}"
git clone --bare git@github-personal:gffhcks/dotfiles.git $HOME/.cfg
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout

# Install Homebrew
echo -e "${RED}Installing homebrew${NC}"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install brew packages
echo -e "${RED}Installing homebrew packages${NC}"
brew install \
  ag \
  android-platform-tools \
  chruby \
  colordiff \
  coreutils \
  direnv \
  git \
  go \
  jq \
  lastpass-cli \
  mas \
  python \
  python3 \
  ruby-build \
  ruby-install \
  shellcheck \
  vim \
  wget

# Load dotfiles
echo -e "${RED}Reloading ~/.bashrc${NC}"
source ~/.bashrc

# As of 6/27/16, latest version provided by ruby-install is the same as system.
# Don't waste time compiling what's already there.
# echo -e "${RED}Installing latest ruby into chruby${NC}"
# ruby-install ruby

# Fix for arrow keys and backspace in mac vim
# TODO: Handle this better. Don't duplicate the line if it's found.
touch ~/.vimrc
cat "set backspace=indent,eol,start" >>~/.vimrc

echo -e "${RED}Installing Caskroom${NC}"
brew tap caskroom/cask

echo -e "${RED}Installing Casks${NC}"
brew cask install \
  atom \
  dropbox \
  flash \
  google-drive \
  hipchat \
  iterm2 \
  silverlight \
  skype \
  sourcetree \
  spotifree \
  spotify \
  spotify-notifications \
  steam \
  sublime-text \
  vagrant \
  virtualbox \
  virtualbox-extension-pack

# Run Spotifree to set up in systray
open /Applications/Spotifree.app

# Run Spotify Notifications to set up in systray
open /Applications/Spotify\ Notifications.app

# Run Box to set up syncing
open /Applications/Box\ Sync.app

echo -e "${RED}Installing Lifesize Cloud${NC}"
cd ~/Downloads
wget http://cdn.lifesizecloud.com/LifesizeCloud-10.2.0-162-signed.pkg
open ./LifesizeCloud-10.2.0-162-signed.pkg
cd ~

# Make GitHub directory
mkdir -p ~/GitHub

# TODO: Handle 'mas signin' better when mas gets updated to prompt for passwords
# TODO: 'mas install' restarts the download/install process even for things that are already there.
# Consider using 'mas list' to check if something is installed first.
echo -e "${RED}Installing apps from the App Store${NC}"
mas signin $masuser $maspass
mas install 406056744 # Evernote
mas install 784801555 # Microsoft OneNote
mas install 823766827 # OneDrive
mas install 568494494 # Pocket
mas install 425955336 # Skitch - Snap. Mark up. Share.
mas install 803453959 # Slack
mas install 425424353 # The Unarchiver
mas install 410628904 # Wunderlist: To-Do List & Tasks
mas install 497799835 # Xcode

# Accept Xcode license
sudo xcodebuild -license

echo -e "${RED}Installing Python Virtualenvwrapper${NC}"
pip install virtualenvwrapper

read -p 'Done. Press ENTER to continue'
