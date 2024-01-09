[UpperLEFTY][repo] / [dotfiles](https://github.com/UpperLEFTY/dotfiles/) / README.md

--------------------------------------------------------------------------------

These are the base dotfiles that I start with when I set up
a new environment (for more specific local needs I use the
[`*.local`](#local-settings) files).

Table of Contents
-----------------

## Installation

```bash
# clone this repository
git clone via terminal or github desktop

# cd into the directory
cd dotfiles

# run the install script in brew folder
# installs homebrew skip if you already have it
./install.sh

# run the bootstrap script in install folder
# installs all the apps and tools
./bootstrap.sh
# restart your computer
```

## What's included

### Brewfile

- [Homebrew](https://brew.sh/) - The missing package manager for macOS

### Dev Tools

- [Git](https://git-scm.com/) - Distributed version control system
- [Node.js](https://nodejs.org/) - JavaScript runtime built on Chrome's V8 JavaScript engine
- [NPM](https://www.npmjs.com/) - Package manager for JavaScript
- [NVM] - Node Version Manager
- [N](https://www.npmjs.com/package/n) - Node.js version management
- [Docker](https://www.docker.com/) - Enterprise Container Platform for High-Velocity Innovation
- [Docker Compose](https://docs.docker.com/compose/) - Define and run multi-container applications with Docker
- [Terrafom](https://www.terraform.io/) - Write, Plan, and Create Infrastructure as Code
- [Terraform Switcher](https://tfswitch.warrensbox.com/) - Switch between different versions of Terraform CLI
- [AWS CLI](https://aws.amazon.com/cli/) - Universal Command Line Interface for Amazon Web Services

### Apps

- [1Password](https://1password.com/) - Password Manager
- ~[LastPass]~ (https://www.forbes.com/sites/daveywinder/2023/03/03/why-you-should-stop-using-lastpass-after-new-hack-method-update/?sh=1fde64f428fc)

### Fonts

- [Nerd Fonts](https://www.nerdfonts.com/) - Iconic font aggregator, collection, & patcher

### Shell

- [Oh My Zsh](https://ohmyz.sh/) - Framework for managing your Zsh configuration

<!-- Link labels: -->

[ci badge macos]: https://github.com/UpperLEFTY/dotfiles/workflows/macOS/badge.svg
[ci badge ubuntu]: https://github.com/UpperLEFTY/dotfiles/workflows/Ubuntu/badge.svg
[ci link macos]: https://github.com/UpperLEFTY/dotfiles/actions?query=workflow%3AmacOS
[ci link ubuntu]: https://github.com/UpperLEFTY/dotfiles/actions?query=workflow%3AUbuntu
[fork]: https://help.github.com/en/github/getting-started-with-github/fork-a-repo
[Git]: src/git
[install macos]: src/os/installs/macos
[install ubuntu]: src/os/installs/ubuntu
[preferences macos]: src/os/preferences/macos
[preferences ubuntu]: src/os/preferences/ubuntu
[repo]: https://github.com/UpperLEFTY
[setup script]: https://github.com/UpperLEFTY/dotfiles/blob/main/src/os/setup.sh#L3
[setup]: src/os/setup.sh
[shell]: src/shell
[symlink]: src/os/create_symbolic_links.sh
[tmux]: src/tmux
[vscode plugins]: src/os/installs/macos/vscode.sh
