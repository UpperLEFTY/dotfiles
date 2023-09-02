#!/bin/bash

# shellcheck disable=all
cd "$(dirname "${ZSH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Browsers\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Chrome" "google-chrome" "--cask"
brew_install "Chromium" "chromium" "--cask" "homebrew/cask-versions"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Firefox" "firefox" "--cask"
brew_install "Firefox Developer" "firefox-developer-edition" "--cask" "homebrew/cask-versions"

if [ -d "/Applications/Firefox.app" ]; then
    execute "defaults write /Applications/Firefox.app/Contents/Info.plist CTFontsVisible -bool true" \
        "Show font choices in Firefox Developer Edition"

    execute "defaults write /Applications/Firefox.app/Contents/Info.plist AppleShowAllFiles YES" \
        "Show hidden files in Firefox Developer Edition"
fi
