#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open `System Preferences` panes in order to
# avoid overriding the preferences that are being changed.

./close_system_preferences_panes.applescript

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./app_store.sh
./chrome.sh
./firefox.sh
./photos.sh
./security_and_privacy.sh
./terminal.sh
./textedit.sh
./ui_and_ux.sh
