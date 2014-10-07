#!/bin/bash

install_zsh() {
  echo "installing zsh"
  if [ `uname` = "Linux" ]; then
    sudo apt-get update;
    sudo apt-get install zsh;
  else
    brew install zsh;
  fi
}

install_oh_my_zsh() {
  install_zsh

  if ! [ -d ~/.oh-my-zsh ]; then
    echo "installing oh-my-zsh"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  fi
}

source_dotfiles() {
  echo "sourcing dotfiles"
  for file in \
    zshrc gitconfig githelpers \
    gitignore ackrc hushlogin \
    rspec vrapperrc pryrc \
    prose.zsh-theme tmux.conf \
    git-template ideavimrc \
    svnhelpers
  do
    original_file=$HOME/.$file
    if [ -e $original_file ]; then
      mv $original_file $original_file.bkp.$$
    fi

    echo "updating $file"
    ln -sf `pwd`/$file $original_file
  done
}

install_oh_my_zsh
source_dotfiles

echo "defininf zsh as the default shell"
chsh -s `which zsh`

echo "done!"
exec zsh --login
