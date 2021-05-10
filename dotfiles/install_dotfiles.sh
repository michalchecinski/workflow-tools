#!/bin/bash

install_dotfile () {
  echo "[+] installing dotfile: $1/$2"
  if [ -f ./current/$1/$2 ]; then
    if [ -f ~/$2 ] || [ -h ~/$2 ]; then
      mv ~/$2 ~/$2.old
      ln -s ${PWD}/current/$1/$2 ~/$2
      rm ~/$2.old
    else
      ln -s ${PWD}/current/$1/$2 ~/$2
    fi
  else
    echo "[!] dotfile doesn't exist: $1/$2"
  fi
}

test_script () {
  install_dotfile "test"
}

ubuntu () {
  install_dotfile ubuntu ".bash_aliases"
  install_dotfile ubuntu ".bashrc"
  install_dotfile ubuntu ".tmux.conf"
  install_dotfile ubuntu ".bash_profile"
  install_dotfile ubuntu ".profile"
  install_dotfile ubuntu ".vimrc"
}

mac () {
  install_dotfile mac ".vimrc"
  install_dotfile mac ".tmux.conf"
  install_dotfile mac ".profile"
  install_dotfile mac ".zshrc"
  install_dotfile mac ".zprofile"
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
    echo "[*] Supported environments: ubuntu, mac, test"
  ;;
esac
