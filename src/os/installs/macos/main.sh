#!/bin/bash

shellcheck disable=SC1091

cd "$(dirname "${ZSH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./zsh.sh

./git.sh
./../nvm.sh
./browsers.sh
./misc_tools.sh
./../npm.sh
./vscode.sh

