###############################
#  custom commands/functions  #
###############################
mtmx() {
  if [ $1 ]; then
    echo "params: $#"
    echo "file: $1"
  else
    tmuxp load .tmuxp/config/default.yaml
  fi
}

nvim() {
  ~/Applications/nvim.appimage $@
}

vim() {
  read -r -p "Did you mean nvim? [Y/n]: " answer
  case $answer in 
    [Yy]*|"") ~/Applications/nvim.appimage $@;;
    *) echo "Exiting...";;
  esac
}

load_env() {
  if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport

    echo "[+] Successfully loaded .env"
  else
    echo "[!] .env doesn't exist"
  fi
}
