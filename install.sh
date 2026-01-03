#!/bin/bash

# Installs all necessary things
if [[ "$OSTYPE" == "darwin"* ]]; then
	if type brew &>/dev/null; then
		echo "Brew is installed"
	else
		echo "Installing Homebrew..."
		echo "See https://brew.sh/"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

  echo "Installing essentials"
  brew install git neovim tmux lazygit

  echo "Configuring git performance for large repos..."
  git config --global core.fsmonitor true
  git config --global core.untrackedCache true

	echo "Installing GNU coreutils..."
	brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

	brew install starship

	echo "Installing Rust..."
	brew install rustup

	echo "Installing applications from cargo..."
	cargo install ripgrep
	cargo install fd-find
else
	echo "Sorry, this system is not supported"
fi
