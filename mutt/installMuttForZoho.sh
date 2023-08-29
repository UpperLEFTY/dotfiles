#!/bin/bash
# Config
muttrcFile='/.muttrc'
muttdirdefault='/.mutt'
# /Config

echo "This script installs mutt and configures it to be used with Gmail or Google Apps"
echo
read -r -p '... Install mutt using Homebrew? [y/N]' muttInstall
if [ "$muttInstall" != "y" ]; then
	echo 'Exiting'
	exit
fi

echo
echo "... Please fill some details"
read -r -p "Full username (username@domain):" userdomain
echo "(Note: you might need an App Password, see this: https://support.google.com/accounts/answer/185833)"
read -r -s -p "Password (will be stored as text in file):" pass
echo
read -r -p "Full name:" fullname
read -r -p "mutt dir (empty for default ~/.mutt)" muttdir
if [ -z "$muttdir" ]; then
	muttdir=$muttdirdefault
fi

muttrcFileExpanded=$(eval echo $muttrcFile)
muttdirExpanded=$(eval echo "$muttdir")
if [ -s "$muttrcFileExpanded" ]; then
	printf %s "$muttrcFile is not empty: \033[31maborting\033[0m"
	exit
fi
if [ -e "$muttdirExpanded" ]; then
	printf %s "mutt dir exists ($muttdirExpanded): \033[31maborting\033[0m"
	exit
fi

echo
echo '... Attempting mutt install'
brew install mutt
if [ ! "$HOME"  -ne 0 ]; then
	echo -e 'brew mutt install: \033[31mfailed\033[0m'
	echo 'Exiting'
	exit
else
	printf %s 'mutt install: \033[32mdone\033[0m'
fi

echo
echo "... Setting $muttrcFile"
{ # See https://stackoverflow.com/a/51113160/1071459
	echo "set imap_user = \"$userdomain\""
	echo "set imap_pass = \"$pass\""
	echo "set smtp_url = \"smtp://$userdomain@smtp.gmail.com:587/\""
	echo "set smtp_pass = \"$pass\""
	echo "set from = \"$userdomain\""
	echo "set realname = \"$fullname\""
	echo "set folder = \"imaps://imap.gmail.com:993\""
	echo "set spoolfile = \"+INBOX\""
	echo "set postponed = \"+[Gmail]/Drafts\""
	echo "set header_cache = $muttdirExpanded/cache/headers"
	echo "set message_cachedir = $muttdirExpanded/cache/bodies"
	echo "set certificate_file = $muttdirExpanded/certificates"
	echo "set move = no"
	echo "set smtp_authenticators = 'gssapi:login'"
} > "$muttrcFileExpanded"

echo
echo "... Creating directories in $muttdir"
mkdir -p "$muttdirExpanded"/cache/headers
mkdir -p "$muttdirExpanded"/cache/bodies
mkdir -p "$muttdirExpanded"/certificates
