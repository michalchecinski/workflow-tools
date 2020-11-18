export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export VISUAL=vim
export EDITOR="$VISUAL"


##########################################
#                                        #
#       custom commands/functions        #
#                                        #
##########################################
function mtmx () {
  if [ $1 ]; then
    echo "params: $#"
    echo "file: $1"
  else
    tmuxp load .tmuxp/config/default.yaml
  fi
}
