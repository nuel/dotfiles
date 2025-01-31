#!/bin/bash

echo "One second... Linking dotfiles..."
# Link the dotfiles
ln -s ~/dotfiles/.aliases ~/.aliases
ln -s ~/dotfiles/.functions ~/.functions
ln -s ~/dotfiles/.projects ~/.projects
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zshrc

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Hi nuel! Let's set things up."

echo -e "Give this machine a name: \c "
read machineName

# Hardware
# --------------------------
# This does tap to click and secondary clicking
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -int 1

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName ${machineName}
sudo scutil --set HostName ${machineName}
sudo scutil --set LocalHostName ${machineName}
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string ${machineName}

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Visuals
# --------------------------
# Show every connected volume
defaults write com.apple.finder ShowHardDrivesOnDesktop -int 1
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -int 1
defaults write com.apple.finder ShowMountedServersOnDesktop -int 1
defaults write com.apple.finder ShowRemovableMediaOnDesktop -int 1

# Finder
# ------------------------
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# TextEdit and Disk Utility
# -------------------------
# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Messages
# ------------------------
# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false


# Kill all affected apps
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
	killall "${app}" > /dev/null 2>&1
done

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Mail" "Messages" "SystemUIServer" \
	"Transmission" "iCal"; do
	killall "${app}" > /dev/null 2>&1
done

echo "All done! Have fun!"
