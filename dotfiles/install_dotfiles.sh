#!/bin/bash

install_dotfile () {
  echo "[+] installing dotfile: $1"
  if [ -f ./current/$1 ]; then
    if [ -f ~/$1 ] || [ -h ~/$1 ]; then
      mv ~/$1 ~/$1.old
      ln -s ${PWD}/current/$1 ~/$1
      rm ~/$1.old
    else
      ln -s ${PWD}/current/$1 ~/$1
    fi
  else
    echo "[!] dotfile doesn't exist: $1"
  fi
}

test_script () {
  install_dotfile "test"
}

ubuntu () {
  install_dotfile ".bash_aliases"
  install_dotfile ".bashrc"
  install_dotfile ".tmux.conf"
  install_dotfile ".bash_profile"
  install_dotfile ".profile"
  install_dotfile ".vimrc"
}

mac () {
  install_dotfile ".vimrc"
  install_dotfile ".tmux.conf"
  install_dotfile ".profile"
  install_dotfile ".zshrc"
  install_dotfile ".zprofile"
}

case $1 in
  "ubuntu")
    ubuntu
  ;;
  "mac")
    mac
  ;;
  "test")
    test_script
  ;;
  *)
    echo "[!] Unrecognized dotfile setup"
  ;;
esac
