#!/bin/bash

# shellcheck disable=SC1091
cd "$(dirname "${ZSH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_bash() {

    declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.zsh.local"

    local configs=""
    local pathConfig=""

    local newShellPath=""
    local brewPrefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `ZSH` version installed through `Homebrew`.

    brewPrefix="$(brew_prefix)" \
        || return 1

    pathConfig="PATH=\"$brewPrefix/bin:\$PATH\""
    configs="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

$pathConfig

export PATH
"

    newShellPath="$brewPrefix/bin/zsh" \

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the `ZSH` version installed through `Homebrew`
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep "$newShellPath" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$newShellPath' | sudo tee -a /etc/shells" \
            "Add '$newShellPath' in '/etc/shells'" \
        || return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set latest version of `ZSH` as the default
    # (macOS uses by default `ZSH` as of 2021).

    chsh -s "$newShellPath" &> /dev/null
    print_result $? "Make OS use the latest version of ZSH"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If needed, add the necessary configs in the
    # local shell configuration file.

    if ! grep "^$pathConfig" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$configs' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "Update '$LOCAL_SHELL_CONFIG_FILE'"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Zsh\n\n"

    brew_install "Zsh" "zsh" \
        && change_default_zsh

    brew_install "zsh-completions" "zsh-completions"

}

main
