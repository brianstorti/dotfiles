#!/bin/bash

install_zsh() {
  if [ `uname` = "Linux" ]; then
    sudo apt-get update;
    sudo apt-get install zsh;
  else
    brew update;
    brew install zsh;
  fi
}

install_oh_my_zsh() {
  install_zsh

  if ! [ -d ~/.oh-my-zsh ]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  fi
}

source_dotfiles() {
  for file in \
    zshrc gitconfig githelpers \
    gitignore ackrc hushlogin \
    rspec vrapperrc pryrc \
    prose.zsh-theme
  do
    original_file=$HOME/.$file
    if [ -e $original_file ]; then
      mv $original_file $original_file.bkp.$$
    fi

    ln -sf `pwd`/$file $original_file
  done
}

install_oh_my_zsh
source_dotfiles

exec zsh --login
