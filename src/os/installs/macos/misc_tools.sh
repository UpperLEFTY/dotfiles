#!/bin/bash

# shellcheck disable=SC1091
cd "$(dirname "${ZSH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous Tools\n\n"

brew_install "ShellCheck" "shellcheck"
brew_install "Unarchiver" "the-unarchiver" "--cask"

if [ -d "$HOME/.nvm" ]; then
    brew_install "Yarn" "yarn"
fi
