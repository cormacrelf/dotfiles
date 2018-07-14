# Disable menu bar transparency
# ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false

# Show remaining battery time; hide percentage
# defaults com.apple.menuextra.battery ShowPercent string "NO"
# defaults com.apple.menuextra.battery ShowTime string "YES"

# Always show scrollbars
# defaults NSGlobalDomain AppleShowScrollBars string "Always"

# Expand save panel by default
# defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true

# Expand print panel by default
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint bool true

# Disable the “Are you sure you want to open this application?” dialog
# ok defaults com.apple.LaunchServices LSQuarantine bool false

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
# ok defaults NSGlobalDomain NSTextShowsControlCharacters bool true

# Disable opening and closing window animations
# defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false

# Increase window resize speed for Cocoa applications
ok defaults NSGlobalDomain NSWindowResizeTime float 0.001

# Disable Resume system-wide
# defaults NSGlobalDomain NSQuitAlwaysKeepsWindows bool false

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems when saving files in Adobe Illustrator CS5 :(
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
ok defaults NSGlobalDomain AppleKeyboardUIMode int 3

# Enable subpixel font rendering on non-Apple LCDs
ok defaults NSGlobalDomain AppleFontSmoothing int 2

# Disable press-and-hold for keys in favor of key repeat
ok defaults NSGlobalDomain ApplePressAndHoldEnabled bool false

# Set a blazingly fast keyboard repeat rate
ok defaults NSGlobalDomain KeyRepeat float 0.01

# Disable auto-correct
# defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

# Enable tap to click (Trackpad) for this user and for the login screen
ok defaults com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking bool true
ok defaults NSGlobalDomain com.apple.mouse.tapBehavior int 1

# Map bottom right Trackpad corner to right-click
# defaults com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick int 2
# defaults com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick bool true
# defaults -currentHost NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior int 1
# defaults -currentHost NSGlobalDomain com.apple.trackpad.enableSecondaryClick bool true

# Require password immediately after sleep or screen saver begins
ok defaults com.apple.screensaver askForPassword int 1
ok defaults com.apple.screensaver askForPasswordDelay int 0

# Save screenshots to the desktop
ok defaults com.apple.screencapture location string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# ok defaults com.apple.screencapturetype string "png"

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
# defaults com.apple.finder QuitMenuItem bool true

# Disable window animations and Get Info animations in Finder
ok defaults com.apple.finder DisableAllAnimations bool true

# Show all filename extensions in Finder
ok defaults NSGlobalDomain AppleShowAllExtensions bool true

# Show status bar in Finder
ok defaults com.apple.finder ShowStatusBar bool true

# Allow text selection in Quick Look
ok defaults com.apple.finder QLEnableTextSelection bool true

# Disable disk image verification
# defaults com.apple.frameworks.diskimages skip-verify bool true
# defaults com.apple.frameworks.diskimages skip-verify-locked bool true
# defaults com.apple.frameworks.diskimages skip-verify-remote bool true

# Automatically open a new Finder window when a volume is mounted
# ok defaults com.apple.frameworks.diskimages auto-open-ro-root bool true
# ok defaults com.apple.frameworks.diskimages auto-open-rw-root bool true
# ok defaults com.apple.finder OpenWindowForNewRemovableDisk bool true

# Display full POSIX path as Finder window title
ok defaults com.apple.finder _FXShowPosixPathInTitle bool true

# Avoid creating .DS_Store files on network volumes
ok defaults com.apple.desktopservices DSDontWriteNetworkStores bool true

# Disable the warning when changing a file extension
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false

# Show item info below desktop icons
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop icons
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
# defaults com.apple.finder WarnOnEmptyTrash bool false

# Empty Trash securely by default
# defaults com.apple.finder EmptyTrashSecurely bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
ok defaults com.apple.NetworkBrowser BrowseAllInterfaces bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Hot corners
# Top left screen corner → Mission Control
# defaults com.apple.dock wvous-tl-corner int 2
# defaults com.apple.dock wvous-tl-modifier int 0
# Top right screen corner → Desktop
# defaults com.apple.dock wvous-tr-corner int 4
# defaults com.apple.dock wvous-tr-modifier int 0
# Bottom left screen corner → Start screen saver
# defaults com.apple.dock wvous-bl-corner int 5
# defaults com.apple.dock wvous-bl-modifier int 0

# Enable highlight hover effect for the grid view of a stack (Dock)
# ok defaults com.apple.dock mouse-over-hilte-stack bool true

# Set the icon size of Dock items to 36 pixels
# defaults com.apple.dock tilesize int 36

# Enable spring loading for all Dock items
# ok defaults com.apple.dock enable-spring-load-actions-on-all-items bool true

# Show indicator lights for open applications in the Dock
# ok defaults com.apple.dock show-process-indicators bool true

# Don’t animate opening applications from the Dock
# ok defaults com.apple.dock launchanim bool false

# Remove the auto-hiding Dock delay
# ok defaults com.apple.Dock autohide-delay float 0
# Remove the animation when hiding/showing the Dock
# ok defaults com.apple.dock autohide-time-modifier float 0

# Enable the 2D Dock
# ok defaults com.apple.dock no-glass bool true

# Automatically hide and show the Dock
# ok defaults com.apple.dock autohide bool true

# Make Dock icons of hidden applications translucent
# ok defaults com.apple.dock showhidden bool true

# Enable iTunes track notifications in the Dock
# defaults com.apple.dock itunes-notifications bool true

# Add a spacer to the left side of the Dock (where the applications are)
#defaults com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Disable shadow in screenshots
# ok defaults com.apple.screencapture disable-shadow bool true

# Disable Safari’s thumbnail cache for History and Top Sites
# defaults com.apple.Safari DebugSnapshotsUpdatePolicy int 2

# Enable Safari’s debug menu
# ok defaults com.apple.Safari IncludeInternalDebugMenu bool true

# Make Safari’s search banners default to Contains instead of Starts With
# ok defaults com.apple.Safari FindOnPageMatchesWordStartsOnly bool false

# Remove useless icons from Safari’s bookmarks bar
# ok defaults com.apple.Safari ProxiesInBookmarksBar "()"

# Add a context menu item for showing the Web Inspector in web views
ok defaults NSGlobalDomain WebKitDeveloperExtras bool true

# Enable the debug menu in Address Book
# ok defaults com.apple.addressbook ABShowDebugMenu bool true

# Enable the debug menu in iCal
# ok defaults com.apple.iCal IncludeDebugMenu bool true

# Only use UTF-8 in Terminal.app
# ok defaults com.apple.terminal StringEncodings array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# This means you can hover over a window and start typing in it without clicking first
#defaults com.apple.terminal FocusFollowsMouse bool true
#defaults org.x.X11 wm_ffm bool true

# Make ⌘ + F focus the search input in iTunes
# ok defaults com.apple.iTunes NSUserKeyEquivalents dict-add "Target Search Field" "@F"

# Disable send and reply animations in Mail.app
# defaults com.apple.Mail DisableReplyAnimations bool true
# defaults com.apple.Mail DisableSendAnimations bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
# ok defaults com.apple.mail AddressesIncludeNameOnPasteboard bool false

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
# ok defaults com.apple.dashboard devmode bool true

# Reset Launchpad
# find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

# Prevent Time Machine from prompting to use new hard drives as backup volume
ok defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup bool true

# Disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disablelocal

# # Remove Dropbox’s green checkmark icons in Finder
# file=/Applications/Dropbox.app/Contents/Resources/check.icns
# [ -e "$file" ] && mv -f "$file" "$file.bak"
# unset file

# # Kill affected applications
# for app in Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer; do killall "$app" > /dev/null 2>&1; done
# echo "Done. Note that some of these changes require a logout/restart to take effect."
