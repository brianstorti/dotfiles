#!/bin/bash

print_message() {
  echo "\033[1;32m"$1"\033[00m";
}

print_warning() {
  echo "\033[1;33m"$1"\033[00m";
}

print_error() {
  echo "\033[1;31m"$1"\033[00m";
}

install_tool() {
  if [ `uname` = "Linux" ]; then
    sudo apt-get install $@;
  else
    brew install $@;
  fi
}

install_zsh() {
  print_message "\nChecking if zsh is already installed."

  if type zsh > /dev/null 2>&1; then
    print_warning "zsh found at '`which zsh`', moving on."
    return
  fi

  print_message "zsh was not found. Trying to install it."
  install_tool "zsh"

  if type zsh > /dev/null 2>&1; then
    print_message "zsh installed (`which zsh`)."
  else
    print_error "It seems that zsh could not be installed. Please try to install it manually and then run this script again."
    exit 1
  fi
}

install_oh_my_zsh() {
  print_message "\nChecking if oh-my-zsh is already installed."

  if [ -d ~/.oh-my-zsh ]; then
    print_warning "Oh-my-zsh is assumed to be installed, because the directory '~/.oh-my-zsh' was found."
    return
  fi

  print_message "Oh-my-zsh was not found. Trying to install it."
  if ! type curl > /dev/null 2>&1; then
    print_warning "First 'curl' need to be installed."
    install_tool "curl"

    if ! type curl > /dev/null 2>&1; then
      print_error "It seems that 'curl' could not be installed, so the oh-my-zsh installation was skiped. Try to install oh-my-zsh manually or make sure 'curl' is available and run this script again."
      return
    fi
  fi

  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

  if [ -d ~/.oh-my-zsh ]; then
    print_message "Oh-my-zsh installed (~/.oh-my-zsh)."
  fi
}

source_dotfiles() {
  print_message "\nSourcing dotfiles."

  for file in `ls files`
  do
    original_file=$HOME/.$file
    if [ -e $original_file ]; then
      print_warning "$original_file was found, so a back up was created for it ($original_file.bkp.$$)."
      mv $original_file $original_file.bkp.$$
    fi

    print_message "Copying $file"
    ln -sf `pwd`/files/$file $original_file
  done
}

set_zsh_as_default_shell() {
  if [ $SHELL != `which zsh` ]; then
    print_message "\nDefining zsh as the default shell."
    chsh -s `which zsh`
    export SHELL=`which zsh`
  fi
}

install_zsh
install_oh_my_zsh
source_dotfiles
set_zsh_as_default_shell

print_message "Done!"
exec zsh --login
