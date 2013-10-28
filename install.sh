#!/bin/sh

install_zsh() {
  if ! [[ -e `which zsh` ]]; then
    if [[ `uname` == "Linux" ]]; then
      sudo apt-get update;
      sudo apt-get install zsh;
    else
      brew update;
      brew install zsh;
    fi
  fi
}

install_oh_my_zsh() {
  install_zsh
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
}

source_dotfile() {
  if [[ -e $2 ]]; then
    cp $2{,.bkp.$$};
    rm $2;
  fi

  ln -s `pwd`/$1 $2;
}

install_oh_my_zsh

source_dotfile "zshrc" "~/.zshrc"
source_dotfile "gitconfig" "~/.gitconfig"
source_dotfile "githelpers" "~/.githelpers"
source_dotfile "gitignore" "~/.gitignore"
source_dotfile "ackrc" "~/.ackrc"
source_dotfile "hushlogin" "~/.hushlogin"
source_dotfile "rspec" "~/.rspec"
source_dotfile "vrapperrc" "~/.vrapperrc"
source_dotfile "pryrc" "~/.pryrc"
