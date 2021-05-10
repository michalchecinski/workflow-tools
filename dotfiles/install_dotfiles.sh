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

install_dir () {
  export -f install_dotfile
  files=$(find ./current/$1 -maxdepth 1 -type f -exec basename {} \;)
  for file in $files
  do
    install_dotfile $1 $file
  done
}

ubuntu () {
  install_dir shared
  install_dir ubuntu
}

mac () {
  install_dir shared
  install_dir mac
}

test_script () {
  install_dotfile "test"
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
