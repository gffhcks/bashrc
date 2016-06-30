#!/bin/bash



# NOTE: For mas to work with free App Store apps, you MUST do this:
# Go to System Preferences/App Store, select 'Save Password' for Free Downloads.

# To run:
# curl https://raw.githubusercontent.com/gffhcks/dotfiles/master/bin/bootstrap_osx.sh > $HOME/bootstrap_osx.sh && chmod +x $HOME/bootstrap_osx.sh && $HOME/bootstrap_osx.sh

# NOTE: The current version of 'mas' in homebrew does not prompt for passwords.
read -p "Mac App Store username: " masuser
read -s -p "Mac App Store password: " maspass
echo ""

# TODO: Add a cron to update brew every 24 hours (maybe around lunchtime)
# TODO: Casks for the following apps:
# Box Sync
# Docker for mac
#
RED='\033[1;31m' # Red and bold
NC='\033[0m' # No Color

# Show hidden files
echo -e "${RED}Forcing OSX to always show hidden files${NC}"
defaults write -g AppleShowAllFiles -bool true

# Pull dotfiles
echo -e "${RED}Cloning dotfiles${NC}"
git --version
read -e -p "Requesting install of developer tools (for Git) - press ENTER to continue after installing"
git clone --bare https://github.com/gffhcks/dotfiles.git $HOME/.cfg
#TODO: What are the implcations of https clone,
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
#TODO: Replace with Cask after it gets added
echo -e "${RED}Installing Box Sync${NC}"
cd ~/Downloads
wget https://e3.boxcdn.net/box-installers/sync/Sync+4+External/Box%20Sync%20Installer.dmg
open ./Box\ Sync\ Installer.dmg
sleep 3
open /Volumes/Box\ Sync\ Installer/Box\ Sync.app
open /Applications/Box\ Sync.app

echo -e "${RED}Installing Docker for Mac Beta${NC}"
cd ~/Downloads
wget https://download.docker.com/mac/beta/Docker.dmg
open ./Docker.dmg
sleep 3
cp -r /Volumes/Docker/Docker.app /Applications/
open /Applications/Docker.app


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
# echo -e "${RED}Installing apps from the App Store${NC}"
# mas signin $masuser $maspass
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

read -p "Done. Press ENTER to continue"
