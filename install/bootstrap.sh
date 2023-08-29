#!/usr/bin/env bash
#
# bootstrap installs all of the dotfiles and dependencies
#
# This script is idempotent, so it can be run multiple times.



cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

info () {
  printf "%s \r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "%s \r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "%s \r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "%s \r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      # ignoring exit 1 from readlink in case where file already exists
      # shellcheck disable=SC2155
      local currentSrc="$(readlink "$dst" || echo)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -r -n 1 action  < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}


prop () {
  PROP_KEY=$1
  PROP_FILE=$2
  PROP_VALUE=$(eval echo "$(cmd < "$PROP_FILE" | grep "$PROP_KEY" | cut -d'=' -f2)")
  echo "$PROP_VALUE"
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read -r linkfile
  do
    cmd < "$linkfile" | while read -r line
    do
        local src dst dir
        src=$(eval echo "$line" | cut -d '=' -f 1)
        dst=$(eval echo "$line" | cut -d '=' -f 2)
        dir=$(dirname "$dst")

        mkdir -p "$dir"
        link_file "$src" "$dst"
    done
  done
}

create_mutt_config () {
    if test -f "$HOME/.muttrc"; then
        success "$HOME/.muttrc file already exists, skipping"
    else
        echo "source $DOTFILES/mutt/muttrc" > "$HOME/.muttrc"
        success 'created ~/.muttrc'
    fi;
    \n 
    if test -f "$HOME/.installMuttForZoho.sh"; then
      success "$HOME/.installMuttForZoho.sh file already exists, skipping"
  else
    echo "export $DOTFILES=$DOTFILES" > "$HOME/.installMuttForZoho.sh"
      success 'created ~/.installMuttForZoho.sh'
  fi
}

create_vim_config () {
    if test -f "$HOME/.vimrc"; then
        success "$HOME/.vimrc file already exists, skipping"
    else
        echo "source $DOTFILES/vim/vimrc" > "$HOME/.vimrc"
        success 'created ~/.vimrc'
    fi
}

create_env_file () {
    if test -f "$HOME/.env.sh"; then
        success "$HOME/.env.sh file already exists, skipping"
    else
        echo "export DOTFILES=$DOTFILES" > "$HOME/.env.sh"
        success 'created ~/.env.sh'
    fi
}

install_dotfiles
create_mutt_config
create_vim_config
create_env_file

echo ''
echo ''
success 'All installed!'



cd "$(dirname "${BASH_SOURCE[0]}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
    # shellcheck disable=SC1090
    source ~/.bash_profile;
}

# shellcheck disable=SC2166
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -r -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
