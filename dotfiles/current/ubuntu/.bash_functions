###############################
#  custom commands/functions  #
###############################
function mtmx () {
  if [ $1 ]; then
    echo "params: $#"
    echo "file: $1"
  else
    tmuxp load .tmuxp/config/default.yaml
  fi
}

function nvim () {
  ~/Applications/nvim.appimage $@
}

function vim () {
  read -r -p "Did you mean nvim? [Y/n]: " answer
  case $answer in 
    [Yy]*|"") ~/Applications/nvim.appimage $@;;
    *) echo "Exiting...";;
  esac
}
