#!/bin/bash

# shellcheck disable=SC1091

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

update
upgrade


./git.sh
./../nvm.sh
./browsers.sh
./misc.sh
./misc_tools.sh
./../npm.sh
./tmux.sh
./../vim.sh

./cleanup.sh
