#!/bin/bash

# Ensure the following is executed as if this script was
# in the project root.
#
# Note: The main reason for doing this is to simplify the
#       output and also have it relative to the project root.
shellcheck source=/scripts/utils/check_markdown_files.sh

cd "$(dirname "${BASH_SOURCE[0]}")/../.." || exit

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

lint() (
    npx markdownlint-cli@^0.32 "$1"
)

check_markdown_files \
    "." \
    lint
